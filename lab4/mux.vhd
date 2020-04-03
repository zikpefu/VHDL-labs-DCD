LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux is
generic(WIDTH: INTEGER := 16);
port (DIN: IN std_logic_vector(WIDTH - 1 downto 0);
		R0: IN std_logic_vector(WIDTH - 1 downto 0);
		R1: IN std_logic_vector(WIDTH - 1 downto 0);
		R2: IN std_logic_vector(WIDTH - 1 downto 0);
		R3: IN std_logic_vector(WIDTH - 1 downto 0);
		R4: IN std_logic_vector(WIDTH - 1 downto 0);
		R5: IN std_logic_vector(WIDTH - 1 downto 0);
		R6: IN std_logic_vector(WIDTH - 1 downto 0);
		R7: IN std_logic_vector(WIDTH - 1 downto 0);
		G: IN std_logic_vector(WIDTH - 1 downto 0);
		sel_lines: IN std_logic_vector(9 downto 0);
		output: OUT std_logic_vector(WIDTH - 1 downto 0));
end mux;

architecture dataflow of mux is
begin
	--select the correct register
	with sel_lines select
	output <= R0 when "0000000001",
				 R1 when "0000000010",
				 R2 when "0000000100",
				 R3 when "0000001000",
				 R4 when "0000010000",
				 R5 when "0000100000",
				 R6 when "0001000000",
				 R7 when "0010000000",
				 G when "0100000000",
				 DIN when others;
end dataflow;