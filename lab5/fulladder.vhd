LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity fulladder is
port( A: IN STD_LOGIC;
		B: IN STD_LOGIC;
		C_IN: IN STD_LOGIC;
		S: OUT STD_LOGIC;
		C_OUT: OUT STD_LOGIC);
end fulladder;

architecture dataflow of fulladder is
begin
--Create a simple adder using dataflow and with select case
	S <= C_IN XOR (A XOR B);
	with (A XOR B) select
	C_OUT <= B when '0',
		  C_IN when others;
	
end dataflow;
