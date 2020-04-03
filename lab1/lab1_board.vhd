LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY lab1_board IS
port(SW: IN STD_LOGIC_VECTOR(3 downto 0);
LEDR: OUT STD_LOGIC_VECTOR(4 downto 0));
END lab1_board;

ARCHITECTURE struct OF lab1_board IS

COMPONENT table
PORT (
V : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
M : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
);
END COMPONENT;

BEGIN
dut : table --device under test
PORT MAP (
--V (IN) is mapped to switches 3 to 0
--M (OUT) is mapped to Leds 4 to 0
V => sw(3 downto 0),
M => ledr(4 downto 0)
);
end struct;