LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity compare_piece IS
	port(a_p: IN STD_LOGIC;
	b_p: IN STD_LOGIC;
	o_p: OUT STD_LOGIC);
end compare_piece;

ARCHITECTURE dataflow OF compare_piece  IS
begin
o_p <= (NOT(a_p) XNOR NOT(b_p));
end dataflow;