LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY blk_box_board IS
port(SW: IN STD_LOGIC_VECTOR(8 downto 0);
LEDR: OUT STD_LOGIC_VECTOR(4 downto 0);
HEX0: OUT STD_LOGIC_VECTOR(6 downto 0);
HEX1: OUT STD_LOGIC_VECTOR(6 downto 0);
HEX2: OUT STD_LOGIC_VECTOR(6 downto 0);
HEX4: OUT STD_LOGIC_VECTOR(6 downto 0);
--error bits
HEX3: OUT STD_LOGIC_VECTOR(6 downto 0);
HEX5: OUT STD_LOGIC_VECTOR(6 downto 0));
END blk_box_board;

ARCHITECTURE blkbox OF blk_box_board IS

COMPONENT blk_box
port(A:IN STD_LOGIC_VECTOR(3 downto 0);
	B: IN STD_LOGIC_VECTOR(3 downto 0);
	C_IN: IN STD_LOGIC;
	HEX0: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	HEX4: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
	sum: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
	carry: OUT STD_LOGIC;
	err: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END COMPONENT;
	signal error: STD_LOGIC_VECTOR(6 DOWNTO 0);

BEGIN
dut : blk_box --device under test
PORT MAP (
--Output the correct components to the pins
A => sw(7 downto 4),
B => sw(3 downto 0),
C_IN => sw(8),
sum => ledr(3 downto 0),
carry => ledr(4),
HEX0 => HEX0(6 downto 0),
HEX1 => HEX1(6 downto 0),
HEX2 => HEX2(6 downto 0),
HEX4 => HEX4(6 downto 0),
err => error
);
--Map error bits to Hex3 and Hex5  (error is either off or a dash '-')
HEX3 <= error;
HEX5 <= error;
end blkbox;