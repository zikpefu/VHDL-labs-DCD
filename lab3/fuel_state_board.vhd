LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY fuel_state_board IS
port(SW: IN STD_LOGIC_VECTOR(9 downto 0);
KEY: IN STD_LOGIC_VECTOR(3 downto 0);
LEDR: OUT STD_LOGIC_VECTOR(9 downto 0)
);
END fuel_state_board;

ARCHITECTURE struct OF fuel_state_board IS
--Bring in component from the state
COMPONENT state_machine
port(clk, reset, w: IN STD_LOGIC;
		z: OUT STD_LOGIC_VECTOR(3 downto 0));
END COMPONENT;

BEGIN
dut : state_machine --device under test
PORT MAP (
--Each is mapped to the boards pins of switches, leds, and keys
clk => KEY(0),
reset => KEY(1),
w => SW(0),
z => LEDR(3 downto 0)
);
end struct;
