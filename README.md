# cublasgemm-benchmark

A simple and repeatable benchmark for validating the GPU performance based on cublas matrix multiplication.

## How to run

Make sure your CUDA tool kit is setup (Your `nvcc` is on `$PATH`, shared libraries on `$LD_LIBRARY_PATH`, headers on `$CPATH`). Then execute the following command to start the test:

```shell
$ ./run.sh
```

* The code does `C=alpha*A*B+beta*C` with square matrices A, B and C and repeate 2 times (adjustable to test longer for more stable result). 

* The sizes of A,B and C are upto (16384,16384) in default test (also adjustable to fit your GPU memory size).

* The default code runs benchmark for GeForce GTX TITAN BLACK (sm_35) (adjustable) to test with cublasSgemm (can also be cublasHgemm for Pascal GPUs).

Uncomment line 11 in `gemm.cu` and line 4 in `run.sh` to test float16 matrix multiplication (cublasHgemm) on Tesla P100 GPU. This needs CUDA 8.0.

## Example Testing  Result

An example testing result can be found in [here](https://github.com/hma02/cublasgemm-benchmark/blob/master/example/output.txt).

The "pstate" ranges from P0 to P12 where P0 is the maximum performance and P12 is the minimum performance.

## See also

* [Mixed-Precision Programming with CUDA 8](https://devblogs.nvidia.com/parallelforall/mixed-precision-programming-cuda-8/)
* [parallel-forall haxpy](https://github.com/parallel-forall/code-samples/tree/master/posts/mixed-precision)
* [cublasSgemmBatched Example](https://github.com/pyrovski/cublasSgemmBatched-example)
* [Why cublasHgemm is slower](https://devtalk.nvidia.com/default/topic/972337/gpu-accelerated-libraries/why-cublashgemm-is-slower-more-than-cublassgemm-when-i-use-/)
* [BLAS Interface for Different Precision](http://www.netlib.org/utk/people/JackDongarra/WEB-PAGES/Batched-BLAS-2016/Day1/precision-blas.pdf)
* [OpenAI gemm](https://github.com/openai/openai-gemm)
* [Useful nvidia-smi Queries](http://nvidia.custhelp.com/app/answers/detail/a_id/3751/~/useful-nvidia-smi-queries)
