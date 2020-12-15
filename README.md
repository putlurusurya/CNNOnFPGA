# CNNOnFPGA

# Python

Python notebook contains code for converting onnx model into a python dictionary

pending - Generating a set of instructions

# Modules

* Systolic array
* weight and data fifo
* 2*2 max pooling
* BlockRam IP integration and weight and data filling
* RELU, Sigmoid, Softmax

Pending
* Control logic
	* Collecting output from sys arr and passing to activation and pooling layers
	* redirecting outputs 
	* instruction decode
	* pipelining
	* If possible fused layer convolution

* Top module


# Instruction set:-

Each instruction lenght - 64 bit

opcode:- 8 bit
 
@dimension1
@dimension2

Tbd

instructions as of now

* read_inputs
* read_weights
* fillfifo
* convolution
* relu
* pooling
* store_outputs
* write_outputs
* reset_total
* reset_fifo
* reset_systolic

Reference
https://github.com/atulapra/8-bit-processor


