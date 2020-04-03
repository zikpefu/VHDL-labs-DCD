LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity adder is
generic(WIDTH: INTEGER := 8);
port (A: IN std_logic_vector(WIDTH downto 0);
		B: IN std_logic_vector(WIDTH downto 0);
		SUM: OUT std_logic_vector(WIDTH downto 0)
);
end adder;

architecture struct of adder is
signal output: std_logic_vector(WIDTH downto 0);
COMPONENT RCadder
generic(WIDTH: INTEGER);
	PORT (
		A: IN STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
		B: IN STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
		C_IN: IN STD_LOGIC;
		S: OUT STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
		C_OUT: OUT STD_LOGIC
		);
END COMPONENT;
begin

RCA: RCadder
  generic map (WIDTH => WIDTH + 1)
  port map    (A => A,
               B => B,
					C_IN => '0',
					S => output,
					C_OUT => open
					);
SUM <= output;
end struct;