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
$SCRIPT_DIR/src/install-cuda.sh
$SCRIPT_DIR/src/install-container-toolkit.sh


echo "Rebooting next, ctrl-c to cancel, enter to reboot"
read
sudo reboot
