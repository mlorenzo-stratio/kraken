#!/bin/bash

set -ex

source examples/devcluster/agent_one_param.sh

# Start kraken agent.
docker run -d \
    --add-host host.docker.internal:$(docker inspect kraken-herd | jq '.[].NetworkSettings.Networks.bridge.IPAddress' -r) \
    -p ${AGENT_PEER_PORT}:${AGENT_PEER_PORT} \
    -p ${AGENT_SERVER_PORT}:${AGENT_SERVER_PORT} \
    -p ${AGENT_REGISTRY_PORT}:${AGENT_REGISTRY_PORT} \
    -v $(pwd)/examples/devcluster/config/agent/development.yaml:/etc/kraken/config/agent/development.yaml \
    -v $(pwd)/examples/devcluster/agent_one_param.sh:/etc/kraken/agent_param.sh \
    -v $(pwd)/examples/devcluster/agent_start_process.sh:/etc/kraken/agent_start_process.sh \
    --name ${AGENT_CONTAINER_NAME} \
    kraken-agent:dev ./agent_start_process.sh
