LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity addsuber is
generic(WIDTH: INTEGER := 16);
port (areg: IN std_logic_vector(WIDTH - 1 downto 0);
		databus: IN std_logic_vector(WIDTH - 1 downto 0);
		addorsub: IN std_logic;
		output: OUT std_logic_vector(WIDTH - 1 downto 0));
end addsuber;

architecture dataflow of addsuber is
signal addsubB: STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
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
  generic map (WIDTH => WIDTH)
  port map    (A => areg,
               B => addsubB,
					C_IN => addorsub,
					S => output,
					--carry out is not needed
					C_OUT => open);
process(addorsub, databus)
begin 
	--if the addsub line is 1 than means to subtract 
	if(addorsub = '1') then 
	--not used to subtract, addorsub is carry_in
		addsubB <= NOT databus;
	else
		addsubB <= databus;
end if;
end process;
end dataflow;