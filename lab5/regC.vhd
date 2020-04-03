LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity regC is

generic(WIDTH: INTEGER := 8);
--input/output
port (input: in std_logic_vector(WIDTH downto 0);
		shift: in std_logic;
		load_reg: in std_logic;
		add_reg: in std_logic;
		shift_out: out std_logic_vector(1 downto 0);
		output: out std_logic_vector(WIDTH downto 0);
		clk: in std_logic
);
end regC;

architecture struct of regC is
signal internal_d: std_logic_vector(WIDTH downto 0);

begin
	process(clk)
	begin
	--Reflect change if clk is high and enable is 1
		if(rising_edge(clk) and (load_reg = '1' or add_reg = '1') and shift = '0') then
			internal_d <= input;
		elsif(rising_edge(clk) and shift = '1' and load_reg = '0' and add_reg = '0') then
			internal_d(WIDTH - 2 downto 0) <= internal_d(WIDTH downto 2);
			internal_d(WIDTH downto WIDTH - 1) <= internal_d(WIDTH) & internal_d(WIDTH);
		else
			internal_d <= internal_d;
		end if;
	end process;
	shift_out <= internal_d(1 downto 0);
	output <= internal_d;
end struct;