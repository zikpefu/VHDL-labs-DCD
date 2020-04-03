LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity reg is
generic(WIDTH: INTEGER := 16);
--input/output
port (databus: IN std_logic_vector(WIDTH - 1 downto 0);
		clk: IN std_logic;
		enable: IN std_logic;
		regout: OUT std_logic_vector(WIDTH - 1 downto 0));
end reg;

architecture struct of reg is
signal internal_d: std_logic_vector(WIDTH - 1 downto 0);

begin
	process(clk)
	begin
	--Reflect change if clk is high and enable is 1
		if(rising_edge(clk) and enable = '1') then
			internal_d <= databus;
		else
			internal_d <= internal_d;
		end if;
	end process;
	regout <= internal_d;
end struct;