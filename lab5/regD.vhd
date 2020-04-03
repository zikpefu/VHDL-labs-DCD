LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity regD is

generic(WIDTH: INTEGER := 4);
--input/output
port (halfbits: in std_logic_vector(WIDTH - 1 downto 0);
		loadreg: in std_logic;
		count: in std_logic;
		finished: out std_logic;
		clk: in std_logic
);
end regD;

architecture struct of regD is
signal internal_d: std_logic_vector(WIDTH - 1 downto 0);
signal zero_sig: std_logic_vector(WIDTH - 1 downto 0);

begin
zero_sig <= (others => '0');
				
	process(clk)
	begin
	--Reflect change if clk is high and enable is 1
		if(rising_edge(clk) and loadreg = '1' and count = '0') then
			internal_d <= halfbits;
		elsif(rising_edge(clk) and count = '1' and loadreg = '0') then
			internal_d(WIDTH - 2 downto 0) <= internal_d(WIDTH - 1 downto 1);
			internal_d(WIDTH - 1) <= '0';
		else
			internal_d <= internal_d;
		end if;
	end process;
	
	finished <= '1' when internal_d = zero_sig else
					 '0';
end struct;