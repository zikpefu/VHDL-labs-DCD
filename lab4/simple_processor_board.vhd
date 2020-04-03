LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY simple_processor_board  IS
generic(WIDTH: INTEGER := 8);
port(SW: IN STD_LOGIC_VECTOR(9 downto 0);
KEY: IN STD_LOGIC_VECTOR(3 downto 0);
LEDR: OUT STD_LOGIC_VECTOR(9 downto 0)
);
END simple_processor_board;

ARCHITECTURE struct OF simple_processor_board  IS
--Bring in component from the state
COMPONENT processor
generic(WIDTH: INTEGER);
port (	DIN: IN std_logic_vector(WIDTH - 1 downto 0);
			CLK: IN std_logic;
			RUN: IN std_logic;
			RESETN: IN std_logic;
			DATABUS: OUT std_logic_vector(WIDTH - 1 downto 0);
			DONE: OUT std_logic);
END COMPONENT;

BEGIN
dut : processor --device under test
generic map (WIDTH => WIDTH)
PORT MAP (
--Each is mapped to the boards pins of switches, leds, and keys
CLK => KEY(0),
RESETN => KEY(1),
RUN => SW(9),
DIN => SW(7 downto 0),
DATABUS => LEDR(7 downto 0),
DONE => LEDR(9)
);
end struct;
