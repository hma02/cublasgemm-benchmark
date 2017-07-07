RED='\e[1;31m'
NC='\e[0m' # No Color or other format

# arch="CUDA_ARCH_FLAGS=-arch=sm_60"
make $arch 

function cublastest_on_GPU
{
	GPUnum=$1
	CUDA_VISIBLE_DEVICES=$GPUnum ./gemm &> cublastest.out &
	P1=$!
	nvidia-smi -i $GPUnum --query-gpu=timestamp,index,name,pcie.link.gen.current,pcie.link.gen.max,pstate,clocks.current.graphics,clocks.max.graphics --format=csv -l 5 &
	P2=$!
	# echo -e "${RED}INFO:${NC} waiting for $P1 and then kill $P2"
	wait $P1 
	kill -9 $P2
	wait $! 2>/dev/null
	
	while read line; do 
	    echo $line # or whaterver you want to do with the $line variable
	done < cublastest.out
}

# mapfile -t lines < <(nvidia-smi topo -m | grep "^GPU[0-9]\+")
# _SIZE=${#lines[@]} # shows the amount of available GPUs

nvidia-smi topo -m | grep "^GPU[0-9]\+" > /tmp/topo.test

_SIZE=$(wc -l < /tmp/topo.test)

echo -e "${RED}INFO:${NC} Running test for all $_SIZE GPU deivce(s) on host $(hostname)"

COUNTER=0

while read line  <&3; do
	echo                    
	echo "=================="
	echo -e "${RED}INFO:${NC} testing GPU$COUNTER"
	echo "=================="
	cublastest_on_GPU $COUNTER
	let COUNTER=COUNTER+1 
done 3< /tmp/topo.test
