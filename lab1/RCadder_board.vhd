LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY RCadder_board IS
port(SW: IN STD_LOGIC_VECTOR(8 downto 0);
LEDR: OUT STD_LOGIC_VECTOR(4 downto 0));
END RCadder_board;

ARCHITECTURE struct OF RCadder_board IS

COMPONENT RCadder
PORT (
	A : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	B : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
	C_IN : IN STD_LOGIC;
	C_OUT : OUT STD_LOGIC;
	S : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
);
END COMPONENT;

BEGIN
dut : RCadder --device under test
PORT MAP (
--Each is mapped to the boards pins of both switches and leds
A => sw(7 downto 4),
B => sw(3 downto 0),
C_IN => sw(8),
S => ledr(3 downto 0),
C_OUT => ledr(4)
);
end struct;