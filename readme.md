# Light-weight Permutation Generator

The Restricted Permutation Network (RPN) generates a restricted subset of permutation of the input image by applying row permutation. 

## Level of Customization
There are 3 configurations of customization available. Multi-stage, Segmented, and Partial

### Multistage Configuration
Set parameter k on top.sv to generate a multistage design. k indicates the number of stages used in RPN, with k=1 referring to a single-stage design. 

### Segmented Configuration
Set parameter N on top.sv to generate a segmented design. N indicates the size of each group in RPN.

### Segmented Configuration
Set parameter R on top.sv to generate a partial design. R indicates the number of rows to apply permutation on.

## Testing

synth.tcl and impl.tcl are 2 tcl provided for users to quickly generate test cases to analyze the resource usage of a particular parameter set up of RPN.  
