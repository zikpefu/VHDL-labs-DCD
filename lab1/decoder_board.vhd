LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY decoder_board IS
port(SW: IN STD_LOGIC_VECTOR(4 downto 0);
HEX0: OUT STD_LOGIC_VECTOR(6 downto 0);
HEX1: OUT STD_LOGIC_VECTOR(6 downto 0));
END decoder_board;

ARCHITECTURE struct OF decoder_board  IS

COMPONENT decoder
PORT (
M : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);
END COMPONENT;

BEGIN
dut : decoder --device under test
PORT MAP (
--Maps to switches (M) and hex displays (Hex1 and Hex2)
M => sw(4 downto 0),
HEX1 => HEX0(6 downto 0),
HEX2 => HEX1(6 downto 0)
);
end struct;