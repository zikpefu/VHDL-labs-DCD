LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity small_mux is
generic(WIDTH: INTEGER := 8);
port (in_adder: in std_logic_vector(WIDTH downto 0);
		output: out std_logic_vector(WIDTH downto 0);
		sel_lines: in std_logic
);
end small_mux;

architecture dataflow of small_mux is
signal not_sel: std_logic;
begin
	--select the correct register
	not_sel <= NOT(sel_lines);
	with not_sel select
	output <= in_adder when '1',
				 (others => '0') when others;
end dataflow;