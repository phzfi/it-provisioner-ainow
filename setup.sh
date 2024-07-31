#!/bin/bash
#Provision laptop for AINow! AI training course
#Ubuntu 24.10 noble
#Lenovo W530 32GB RAM, 8CPU, Nvidia Quadro K2000M

#Detect GPU
TEST=`sudo lspci |grep -i nvidia |wc -l`
if test $TEST -eq 0; then
    echo "Warning: no GPU detected, proceed with CPU only?"
    read
fi

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )


#Install Nvidia drivers
#Note! newer drivers don't support Quadro K2000M
sudo apt update
sudo apt install -y nvidia-utils-460 nvidia-driver-460

#Install common tools
sudo apt install -y apt install git nano less curl chromium-browser apt-transport-https ca-certificates
$SCRIPT_DIR/src/setup-git.sh
$SCRIPT_DIR/src/install-docker.sh

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


#Install container toolkit
curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/stable/deb/nvidia-container-toolkit.list | \
    sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
    sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
sudo apt-get update
sudo apt-get install -y nvidia-container-toolkit
sudo nvidia-ctk runtime configure --runtime=docker
sudo systemctl restart docker


echo "Rebooting next, ctrl-c to cancel, enter to reboot"
read
sudo reboot
