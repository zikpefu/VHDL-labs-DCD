LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY comparator IS
generic(WIDTH: INTEGER := 8);
port(A: IN STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
B: IN STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
O: OUT STD_LOGIC);
END comparator;

ARCHITECTURE behavior OF comparator  IS

component compare_piece IS
	port(a_p: IN STD_LOGIC;
	b_p: IN STD_LOGIC;
	o_p: OUT STD_LOGIC);
end component;

component generic_nand is
	generic(WIDTH: INTEGER);
	port(a		: in std_logic_vector(WIDTH-1 downto 0);
	     output	: out std_logic);
end component;

signal s: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
begin
   CMP: 
   for I in WIDTH -1  downto 0 generate
      COMPI : compare_piece 	
		port map (
		a_p => A(I),
		b_p => B(I),
		o_p => s(I)
		);
   end generate CMP;
CMB: generic_nand
  generic map (WIDTH => WIDTH)
  port map    (a => s,
               output => O);
end behavior;