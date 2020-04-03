LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity regB is

generic(WIDTH: INTEGER := 8);
--input/output
port (multiplier: in std_logic_vector(WIDTH - 1 downto 0);
		loadreg: in std_logic;
		shift: in std_logic;
		c_input: in std_logic_vector(1 downto 0);
		product: out std_logic_vector(WIDTH - 1 downto 0);
		sel_line: out std_logic_vector(2 downto 0);
		clk: in std_logic
);
end regB;

architecture struct of regB is
signal internal_d: std_logic_vector(WIDTH - 1 downto 0);
signal dummy: std_logic;
--line from register is the select line to mux
begin
	process(clk)
	begin
	--Reflect change if clk is high and enable is 1
		if(rising_edge(clk) and loadreg = '1' and shift = '0') then
		--I want to load the value of multipler so next time i can shift
			internal_d <= multiplier;
			dummy <= '0';
		elsif(rising_edge(clk) and shift = '1' and loadreg = '0') then
			--becasue it was loaded i can shfit the value over by two bits
			internal_d(WIDTH - 3 downto 0) <= internal_d(WIDTH - 1 downto 2);
			internal_d(WIDTH - 1 downto WIDTH - 2) <= c_input(1 downto 0);
			dummy <= internal_d(1);
		else
			internal_d <= internal_d;
		end if;
	end process;
	product <= internal_d;
	sel_line(2 downto 1) <= internal_d(1 downto 0);
	sel_line(0) <= dummy;
	
end struct;