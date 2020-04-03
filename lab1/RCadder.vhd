LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCadder IS
port(A: IN STD_LOGIC_VECTOR(3 downto 0);
	B: IN STD_LOGIC_VECTOR(3 downto 0);
	C_IN: IN STD_LOGIC;
	S: OUT STD_LOGIC_VECTOR(3 downto 0);
	C_OUT: OUT STD_LOGIC);
END RCadder;

ARCHITECTURE struct OF RCadder IS

signal c: STD_LOGIC_VECTOR(2 downto 0);

COMPONENT fulladder
PORT (
A : IN STD_LOGIC;
B: IN STD_LOGIC;
C_IN: IN STD_LOGIC;
C_OUT: OUT STD_LOGIC;
S: OUT STD_LOGIC);
END COMPONENT;
 
BEGIN
--Using a port map, each pin is mapped to depict the figure in the lab description (Part 3d)
--'c' is an internal signal that is carried to each of the adders to form a 
--ripple carry adder
adder1: fulladder
PORT MAP (
A => A(0),
B => B(0),
C_OUT => c(0),
C_IN => C_IN,
S => S(0)
);
adder2: fulladder
PORT MAP (
A => A(1),
B => B(1),
C_OUT => c(1),
C_IN => c(0),
S => S(1)
);
adder3: fulladder
PORT MAP (
A => A(2),
B => B(2),
C_OUT => c(2),
C_IN => c(1),
S => S(2)
);
adder4: fulladder
PORT MAP (
A => A(3),
B => B(3),
C_OUT => C_OUT,
C_IN => c(2),
S => S(3)
);
end struct;