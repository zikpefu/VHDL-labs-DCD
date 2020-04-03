LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity blk_box is
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
end blk_box;


architecture blk_box_struct of blk_box is
signal tableA_out, tableB_out, tableRC_out: STD_LOGIC_VECTOR(4 downto 0);		
signal sum_out: STD_LOGIC_VECTOR(4 downto 0);
signal carry_out: STD_LOGIC;
COMPONENT table
PORT (
V : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
M : OUT STD_LOGIC_VECTOR(4 DOWNTO 0)
);
END COMPONENT;

COMPONENT decoder
PORT (
M : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
HEX1 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
HEX2 : OUT STD_LOGIC_VECTOR(6 DOWNTO 0)
);
END COMPONENT;

COMPONENT RCadder
port(A: IN STD_LOGIC_VECTOR(3 downto 0);
	B: IN STD_LOGIC_VECTOR(3 downto 0);
	C_IN: IN STD_LOGIC;
	S: OUT STD_LOGIC_VECTOR(3 downto 0);
	C_OUT: OUT STD_LOGIC);
END COMPONENT;
--Port map all components from past projects together to form a black box
begin
--table
tableA: table
--adjust V so that M can accept V as an input
PORT MAP (
V(4) => '0',
V(3 downto 0)=> A,
M => tableA_out
);

tableB: table
PORT MAP (
V(4) => '0',
V(3 downto 0)=> B,
M => tableB_out
);

tableRC: table
PORT MAP(
V => sum_out,
M => tableRC_out
);

--decoder
decoderA: decoder
PORT MAP(
M => tableA_out,
HEX1 => hex4,
--HEX2 needs to be deactivated 
HEX2 => open
);
decoderB: decoder
PORT MAP(
M => tableB_out,
HEX1 => hex2,
--HEX2 needs to be deactivated 
HEX2 => open
);
decoderRC: decoder
PORT MAP(
M => tableRC_out,
HEX1 => hex0,
HEX2 => hex1
);
--rc_adder
rc_adder: RCadder
PORT MAP(
A => A,
B => B,
C_IN => C_IN,
S => sum_out(3 downto 0),
C_OUT => carry_out
);
--Output the signals to both the sum and carry out 
sum_out(4) <= carry_out;
sum <= sum_out(3 downto 0);
carry <= carry_out;

--Create the error bit for when A and B exceed 9
process(A,B)
begin
if(A > "1001" OR B > "1001") then
	err <= "0111111";
else
   err <= "1111111";
	end if;
end process;

end blk_box_struct;