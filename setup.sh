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

#Install Nvidia drivers
#Note! newer drivers don't support Quadro K2000M
sudo apt update
sudo apt install -y nvidia-utils-460 nvidia-driver-460

#Install common tools
sudo apt install -y apt install git nano less curl chromium-browser apt-transport-https ca-certificates

#Install CUDA
sudo apt-get install -y linux-headers-$(uname -r)
sudo apt-key del 7fa2af80
distro=ubuntu2404
arch=x86_64
wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-archive-keyring.gpg
sudo mv cuda-archive-keyring.gpg /usr/share/keyrings/cuda-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/cuda-archive-keyring.gpg] https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/ /" | sudo tee /etc/apt/sources.list.d/cuda-$distro-$arch.list
sudo apt update
sudo apt-get install -y cuda-toolkit nvidia-gds

#Install Docker
sudo apt-get install -y ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

gpasswd -a ainow docker


echo "Rebooting next, ctrl-c to cancel, enter to reboot"
read
sudo reboot
