#!/bin/bash
apt-get update
CONT=nvcr.io/nvidia/hpc-benchmarks:24.03
docker pull $CONT
## 
echo -------------stream benchmark-------------
docker run --gpus all --shm-size=10g ${CONT} mpirun -np 1 ./stream-gpu-test.sh





echo -------------HPL benchmark with 1 card-------------
docker run --gpus all --shm-size=10g ${CONT} mpirun -np 1 ./hpl.sh --dat ./hpl-linux-x86_64/sample-dat/HPL-1GPU.dat

echo -------------HPL benchmark with 2 card-------------
docker run --gpus all --shm-size=10g ${CONT} mpirun -np 2 ./hpl.sh --dat ./hpl-linux-x86_64/sample-dat/HPL-2GPUs.dat

echo -------------HPL benchmark with 8 card-------------
docker run --gpus all --shm-size=10g ${CONT} mpirun -np 8 ./hpl.sh --dat ./hpl-linux-x86_64/sample-dat/HPL-8GPUs.dat







echo -------------HPL MxP 1 cards----------------------
docker run --gpus all --shm-size=10g ${CONT}  mpirun --bind-to none -np 2   ./hpl-mxp.sh --n 163840 --nb 2048 --nprow 2 --npcol 1 --nporder row --gpu-affinity 0:1

echo -------------HPL MxP 2 cards----------------------
docker run --gpus all --shm-size=10g ${CONT} mpirun --bind-to none -np 1   ./hpl-mxp.sh --n 102400 --nb 2048  --nprow 1 --npcol 1 --nporder row --gpu-affinity 0 


echo -------------HPL MxP 4 cards----------------------
docker run --gpus all --shm-size=10g ${CONT} mpirun --bind-to none -np 4 \
     ./hpl-mxp.sh --n 190000 --nb 2048 --nprow 2 --npcol 2 --nporder row --gpu-affinity 0:1:2:3

echo -------------HPL MxP 8 cards----------------------
docker run --gpus all --shm-size=10g ${CONT} mpirun --bind-to none -np 8 \
     ./hpl-mxp.sh --n 380000 --nb 2048 --nprow 2 --npcol 4 --nporder row --gpu-affinity 0:1:2:3:4:5:6:7

