# <h1 align = "center">🧑‍🎓Single Cycle Processor🧑‍🎓

<h3 align = "center">A couple simple projects I worked on using python

# Components
- [FlipFlop](lab5_koganti1_Anoop_Koganti/FlipFlop.v) - a D FlipFlop taking in 8-bit input and provided 8-bit output.

- [Multiplexer](lab5_koganti1_Anoop_Koganti/Mux.v) - a 2-1 Multiplexer that takes in 32-bit input and provides 32-bit output.

- [Arithmetic Logic Unit (ALU)](lab5_koganti1_Anoop_Koganti/ALU.v) - capable of doing signed addition, signed subtraction, AND comparisonm OR comparison, NOR comparison, Equality check, and Set Less Then (signed).

- [ALU Controller](lab5_koganti1_Anoop_Koganti/ALUController.v) - takes funct3 and funct7 inputs from datapath to provide 4-bit output for the ALU to decide which operation it does.

- [Register File](lab5_koganti1_Anoop_Koganti/RegFile.v) - Stores values into a 32 element array and reads thems depending on inputs.

- [Instruction Memory](lab5_koganti1_Anoop_Koganti/InstMem.v) - holds the stored operation values in a 32 element array that decide which operations are used for computation

- [Immediate Generator](lab5_koganti1_Anoop_Koganti/ImmGen.v) - Determines instruction type (R-type, S-type, I-type)

- [Data Memory](lab5_koganti1_Anoop_Koganti/DataMem.v) - Used to store and load values, differing from Instruction Memory in that in the Instruction Memory, all the values are already stored in it.

- [DataPath](lab5_koganti1_Anoop_Koganti/Datapath.v) - Executes instructions and operations in a single clock Cycle

- [Controller](lab5_koganti1_Anoop_Koganti/Controller.v) - takes an 7-bit input that decides specific outputs that are then sent to the datapath and ALUController

# Processor 

- [Processor](lab5_koganti1_Anoop_Koganti/processor.v) - The Final design with all the submodules listed above
