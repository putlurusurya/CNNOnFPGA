# CNNOnFPGA

# Python

Python notebook contains code for converting onnx model into a python dictionay
pending - Generating a set of instructions

# Modules

* Systolic array
* weight and data fifo
* 2*2 max pooling
* BlockRam
* RELU, Sigmoid, Softmax

Pending
* Control logic
* Top module


# Instruction set:-

Each instruction lenght tbd

opcode:- 5 bit 

read_inputs
read_weights
fillfifo
convolution
relu
pooling
store_outputs
write_outputs
reset_total
reset_fifo
reset_systolic

Reference
https://github.com/atulapra/8-bit-processor


