#!/bin/bash

echo "Downloading required libraries..."

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update

sudo apt install libnccl2=2.28.7-1+cuda12.9 libnccl-dev=2.28.7-1+cuda12.9 -y
sudo apt install build-essential devscripts debhelper fakeroot -y
make pkg.debian.build
ls build/pkg/deb/
echo "cloning nccl test"
git clone https://github.com/NVIDIA/nccl-tests.git
cd nccl-install-test/nccl-tests
./build/all_reduce_perf -b 8 -e 256M -f 2 -g 2

echo "done"
