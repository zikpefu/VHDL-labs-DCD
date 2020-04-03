LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY multiplier_board  IS
generic(WIDTH: INTEGER := 4);
port(SW: IN STD_LOGIC_VECTOR(9 downto 0);
KEY: IN STD_LOGIC_VECTOR(3 downto 0);
LEDR: OUT STD_LOGIC_VECTOR(9 downto 0)
);
END multiplier_board;

ARCHITECTURE struct OF multiplier_board  IS
--Bring in component from the state
COMPONENT bit_pair_multiplier
generic(WIDTH: INTEGER);
port (	MULTIPLICAND: IN std_logic_vector(WIDTH - 1 downto 0);
			MULTIPLIER: IN std_logic_vector(WIDTH - 1 downto 0);
			START: IN std_logic;
			CLK: IN std_logic;
			RESETN: IN std_logic;
			DONE: OUT std_logic;
			BUSY: OUT std_logic;
			PRODUCT: OUT std_logic_vector((WIDTH * 2) - 1 downto 0));
END COMPONENT;

BEGIN
dut : bit_pair_multiplier --device under test
generic map (WIDTH => WIDTH)
PORT MAP (
--Each is mapped to the boards pins of switches, leds, and keys
CLK => KEY(0),
RESETN => KEY(1),
START => SW(9),
MULTIPLICAND => SW(7 downto 4),
MULTIPLIER => SW(3 downto 0),
PRODUCT => LEDR(7 downto 0),
DONE => LEDR(9),
BUSY => LEDR(8)
);
end struct;
