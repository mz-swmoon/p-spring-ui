#!/usr/bin/env bash


cf create-service p.service-registry standard registry-server

cf create-service -c '{ "git": { "uri": "https://github.com/mz-swmoon/p-configs.git", "label": "master"  } }' p.config-server standard config-server

cf push -f manifest.yml --no-start

cf bind-service pspring_ui config-server

cf bind-service pspring_ui registry-server

cf start pspring_ui
