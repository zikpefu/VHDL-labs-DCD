LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCadder IS
generic(WIDTH: INTEGER := 16);
port(A: IN STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
	B: IN STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
	C_IN: IN STD_LOGIC;
	S: OUT STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
	C_OUT: OUT STD_LOGIC);
END RCadder;

ARCHITECTURE struct OF RCadder IS

signal c: STD_LOGIC_VECTOR(WIDTH - 2 downto 0);

COMPONENT fulladder
PORT (
A : IN STD_LOGIC;
B: IN STD_LOGIC;
C_IN: IN STD_LOGIC;
C_OUT: OUT STD_LOGIC;
S: OUT STD_LOGIC);
END COMPONENT;
 
BEGIN
--Using a port map, each pin is mapped to depict the figure in the lab description (Part WIDTHd)
--'c' is an internal signal that is carried to each of the adders to form a 
--ripple carry adder

adderfnt: fulladder
PORT MAP (
A => A(0),
B => B(0),
C_OUT => c(0),
C_IN => C_IN,
S => S(0)
);

addr:
	for I in 1 to WIDTH - 2 generate
		addermid: fulladder		
			PORT MAP (
			A => A(I),
			B => B(I),
			C_OUT => c(I),
			C_IN => c(I - 1),
			S => S(I)
			);
	end generate addr;

adderbck: fulladder
PORT MAP (
A => A(WIDTH - 1),
B => B(WIDTH - 1),
C_OUT => C_OUT,
C_IN => c(WIDTH - 2),
S => S(WIDTH - 1)
);

end struct;