


spack install -j 40 ucx +cuda+cma+dc+dm+gdrcopy+ib_hw_tm+mlx5_dv+rc+ud+rdmacm+verbs+thread_multiple
spack install -j 40 openmpi +cuda fabrics=ucx "^ucx"
spack install -j 40 osu-micro-benchmarks +cuda ^openmpi

spack load osu-micro-benchmarks
HOST=`hostname`
`which mpirun` -np 2 -host $HOST:1,$HOST:1 `which osu_bw`  -m 64000000

`which mpirun` -np 2 -host $HOST:1,$HOST:1 `which osu_bw`  -d cuda -m 64000000