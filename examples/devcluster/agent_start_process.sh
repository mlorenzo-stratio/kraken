#!/bin/bash


source /etc/kraken/agent_param.sh

/usr/bin/kraken-agent --config=/etc/kraken/config/agent/development.yaml --peer-ip=${HOSTNAME} --peer-port=${AGENT_PEER_PORT} --agent-server-port=${AGENT_SERVER_PORT} --agent-registry-port=${AGENT_REGISTRY_PORT} &

sleep 3
chmod og+w /tmp/kraken-agent-registry.sock 2> /dev/null

tail -F /var/log/kraken/nginx-error.log /var/log/kraken/kraken-agent/agent-access.log /var/log/kraken/kraken-agent/agent-error.log /var/log/kraken/kraken-agent/nginx-stdout.log /var/log/kraken/kraken-agent/stdout.log /var/log/kraken/kraken-agent/torrent.log /var/log/nginx/error.log