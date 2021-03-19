# CNNOnFPGA



# Architecture
![Data path](./media/datapath.jpeg)
## Data Path
* Systolic Array
	* Processing Element
![Processing Element](./media/processingElement.jpeg)
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
![control path](./media/controlpath.jpeg)
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

# Python

Python notebook contains code for converting onnx model into a python dictionary

# Current Status and future work

Current version of the hardware accelerator can be scaled only upto 16x16 matrix multiplication unit. Instruction generator is under development. The accelerator is not deployed on to FPGA. Post synthesis and Post implementation functional simulation is verified. Timing simulation is yet to be done.
 
Future work for this project includes:-
* Improve the architecture with software optimisations in consideration
* Add DDR3 memory or other external memory support
* SD card support for live camera detection
* Improve the matrix multiplication model with a better architecture 
* Improve timing constraints

