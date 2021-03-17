# CNNOnFPGA

# Python

Python notebook contains code for converting onnx model into a python dictionary

pending - Generating a set of instructions

# Modules

## Data Path
* Systolic Array
	* Processing Element
* FIFO array
	* FIFO
* MUXES
* Bias adder
* demux array
	* demux
* Activations
	* Relu
	* Sigmoid
* 2*2 Max pooling
* ROM
	* Weight and Bias ROM
	* Input ROM
* Buffer ram array
	* Buffer RAM
* Matrix adder

## Control path
* Master Control
* FIFO fill control
* FIFO refill control
* Weight fill control
* Bias fill control
* Buffer fill control
* Maxpool fill control
* Buffer refill control

# Supported instructions Instruction:-

Each instruction lenght - 64 bit

opcode:- 5 bit

* Weight fill
	* opcode = 00001
	* Weight initial address = 15 bits
	* Weight size = 16 bits
	* number of filters = 16 bits
* Fifo clear
	* opcode = 10000
* Fifo fill
	* opcode = 00010
	* fifo initial address = 14 bits
	* image height = 16 bits
	* image width = 16 bits
	* fifo offset = 7 bits  
* Fifo refill
	* opcode = 00101
* Conv
	* opcode = 00011
	* activation code = 4 bits
	* output feature map size = 16 bits
	* buffer initial address = 16 bits
* Maxpool
	* opcode = 00100
	* maxpool initial address = 16 bits
	* output feature map size = 16 bits
	* buffer initial address = 16 bits
* Add matrices
	* opcode = 00111
	* in address = 14 bits
	* out address = 14 bits

