#!/bin/bash
#Install kohya_ss training tool
#In venv

echo | sudo add-apt-repository ppa:deadsnakes/ppa
sudo apt install -y python3.10 python3.10-venv python3.10-tk

#start kohya_ss
mkdir -p ~/workspace/docker
cd ~/workspace/docker
test ! -d kohya_ss && git clone https://github.com/bmaltais/kohya_ss
cd ~/workspace/docker/kohya_ss

mkdir -p data/res
mkdir -p models/vae

python3.10 -v venv venv
venv/bin/activate
./setup.sh
./gui.sh

