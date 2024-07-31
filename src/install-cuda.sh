#!/bin/bash
#Install CUDA
sudo apt-get install -y linux-headers-$(uname -r)
sudo apt-key del 7fa2af80
distro=ubuntu2404
arch=x86_64
#wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-archive-keyring.gpg
#sudo mv cuda-archive-keyring.gpg /etc/apt/keyrings/cuda-archive-keyring.gpg
#echo "deb [signed-by=/etc/apt/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/ /" | sudo tee /etc/apt/sources.list.d/cuda-$distro-$arch.list
#TODO use legacy key management
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/3bf863cc.pub
echo "deb https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/ /" | sudo tee /etc/apt/sources.list.d/cuda-$distro-$arch.list
sudo apt update
sudo apt-get install -y cuda-toolkit
