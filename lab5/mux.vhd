LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity mux is
generic(WIDTH: INTEGER := 8);
port (two: in std_logic_vector(WIDTH downto 0);
		negtwo: in std_logic_vector(WIDTH downto 0);
		one: in std_logic_vector(WIDTH downto 0);
		negone: in std_logic_vector(WIDTH downto 0);
		output: out std_logic_vector(WIDTH downto 0);
		sel_lines: in std_logic_vector(2 downto 0)
);
end mux;

architecture dataflow of mux is
begin
	--select the correct register
	with sel_lines select
	output <= one when "001",
				 one when "010",
				 two when "011",
				 negtwo when "100",
				 negone when "101",
				 negone when "110",
				 (others => '0') when others;
end dataflow;