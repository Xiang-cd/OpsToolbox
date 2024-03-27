
git clone https://github.com/NVIDIA/nccl-tests.git
cd nccl-tests
make CUDA_HOME=/usr/local/cuda -j
./build/all_reduce_perf -b 1g -e 8g -f 2 -g 8
./build/sendrecv_perf -b 1g -e 8g -f 2 -g 2