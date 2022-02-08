# Test Bench Generator
Automatic test bench generator used during the verification phase of the project.
## Principle of operation
The script writes pseudo-random images in the RAM through a reverse-generation process.

Generating pixels first would result in a high probability of obtaining two pixels with distant values on large images, leading to testing the module only on an unitary shift level.
To ensure a complete coverage of each input type, the script produces a random shift level first, and then backtracks by calculating the maximum and minimum pixel values. The full image is then randomly generated based on the corresponding pixel domain.
## Usage
You need a system with Python 3. No other dependency is required.

To run:
```bash
python3 tb_generator.py
```
The script will create in the same directory a file named ```tb.vhd```, containing both RAM assignments and the asserts required to validate the component's operation.
### Output example
```tb.vhd``` file:
```vhdl
signal RAM: ram_type :=
	(0 => std_logic_vector(to_unsigned(5, 8)),
	1 => std_logic_vector(to_unsigned(2, 8)),
	2 => std_logic_vector(to_unsigned(234, 8)),
	3 => std_logic_vector(to_unsigned(244, 8)),
	4 => std_logic_vector(to_unsigned(241, 8)),
	5 => std_logic_vector(to_unsigned(240, 8)),
	6 => std_logic_vector(to_unsigned(244, 8)),
	7 => std_logic_vector(to_unsigned(245, 8)),
	8 => std_logic_vector(to_unsigned(246, 8)),
	9 => std_logic_vector(to_unsigned(233, 8)),
	10 => std_logic_vector(to_unsigned(237, 8)),
	11 => std_logic_vector(to_unsigned(245, 8)),
	others =>(others =>'0'));

assert RAM(12) = std_logic_vector(to_unsigned(32, 8)) report "TEST FALLITO (WORKING ZONE). Expected 32 found " & integer'image(to_integer(unsigned(RAM(12)))) severity failure;
assert RAM(13) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(13)))) severity failure;
assert RAM(14) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(14)))) severity failure;
assert RAM(15) = std_logic_vector(to_unsigned(224, 8)) report "TEST FALLITO (WORKING ZONE). Expected 224 found " & integer'image(to_integer(unsigned(RAM(15)))) severity failure;
assert RAM(16) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(16)))) severity failure;
assert RAM(17) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(17)))) severity failure;
assert RAM(18) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(18)))) severity failure;
assert RAM(19) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(19)))) severity failure;
assert RAM(20) = std_logic_vector(to_unsigned(128, 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM(20)))) severity failure;
assert RAM(21) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(21)))) severity failure;
```
Log:
```bash
> Delta value = 13
> Shift level = 5
```
