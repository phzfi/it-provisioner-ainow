#!/bin/bash
#Install Stable Diffusion Docker

mkdir -p ~/workspace/docker
cd ~/workspace/docker
git clone https://github.com/AbdBarho/stable-diffusion-webui-docker.git
cd stable-diffusion-webui-docker

docker compose --profile download up --build
docker compose --profile auto-cpu up --build
