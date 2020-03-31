#!/usr/bin/env bash

# grab avatars from github
./gource-fetch_avatars.pl

# play github gource video and store it
gource  \
	--user-image-dir .git/avatar/ \
        -s .5 \
        -1920x1080 \
	--multi-sampling \
	--stop-at-end \
	--key \
	--highlight-users \
	--hide mouse,progress \
	--file-idle-time 0 \
	--max-files 0 \
	--background-colour 000000 \
	--font-size 22 \
	--title "$(basename $PWD) repo" \
	--start-date '2020-03-06 00:00:00' \
	--output-ppm-stream - \
	--output-framerate 30 | \
		ffmpeg -y \
		-r 60 \
		-f image2pipe \
		-vcodec ppm \
		-i - \
		-vcodec libx264 \
		-preset ultrafast \
		-pix_fmt yuv420p \
		-crf 1 \
		-threads 0 \
		-bf 0 gource-video.mp4
