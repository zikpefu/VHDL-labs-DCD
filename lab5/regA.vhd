LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity regA is

generic(WIDTH: INTEGER := 8);
--input/output
port (multiplicand: IN std_logic_vector(WIDTH - 1 downto 0);
		loadreg: IN std_logic;
		clk: IN std_logic;
		regout_2: OUT std_logic_vector(WIDTH downto 0); --1100 --> 1000 <- WRONG : 11000 <- RIGHT!
		regout_neg2: OUT std_logic_vector(WIDTH downto 0);
		regout_1: OUT std_logic_vector(WIDTH downto 0);
		regout_neg1: OUT std_logic_vector(WIDTH downto 0));
end regA;

architecture struct of regA is
signal internal_d: std_logic_vector(WIDTH - 1 downto 0);
signal twos_complement: std_logic_vector(WIDTH -1 downto 0);

COMPONENT addsuber
generic(WIDTH: INTEGER);
port (areg: IN std_logic_vector(WIDTH - 1 downto 0);
		databus: IN std_logic_vector(WIDTH - 1 downto 0);
		addorsub: IN std_logic;
		output: OUT std_logic_vector(WIDTH - 1 downto 0));
end COMPONENT;

begin
AS: addsuber
  generic map (WIDTH => WIDTH)
  port map    (areg => (others => '0'),
               databus => internal_d,
					addorsub => '1',
					output => twos_complement
					);
	process(clk)
	begin
	--Reflect change if clk is high and enable is 1
		if(rising_edge(clk) and loadreg = '1') then
			internal_d <= multiplicand;
		else
			internal_d <= internal_d;
		end if;
	end process;
	regout_1(WIDTH - 1 downto 0) <= internal_d;
	regout_1(WIDTH) <= internal_d(WIDTH - 1);
	regout_neg1(WIDTH - 1 downto 0) <= twos_complement;
	regout_neg1(WIDTH) <= twos_complement(WIDTH - 1);
	regout_2(WIDTH downto 1) <= internal_d;
	regout_2(0) <= '0';
	regout_neg2(WIDTH downto 1) <= twos_complement;
	regout_neg2(0) <= '0';
end struct;