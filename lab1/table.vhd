LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity table is
port( V: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		M: OUT STD_LOGIC_VECTOR(4 DOWNTO 0));
end table;


architecture data of table is
begin
	process(V)
	begin
	--Convert V values into M values 
	--using the given table in lab notes
	if (V = "00000") then
	M <= "00000";
	elsif (V = "00001") then
	M <= "00001";
	elsif (V = "00010") then
	M <= "00010";
	elsif (V = "00011") then
	M <= "00011";
	elsif (V = "00100") then
	M <= "00100";
	elsif (V = "00101") then
	M <= "00101";
	elsif (V = "00110") then
	M <= "00110";
	elsif (V = "00111") then
	M <= "00111";
	elsif (V = "01000") then
	M <= "01000";
	elsif (V = "01001") then
	M <= "01001";
	elsif (V = "01010") then
	M <= "10000";
	elsif (V = "01011") then
	M <= "10001";
	elsif (V = "01100") then
	M <= "10010";
	elsif (V = "01101") then
	M <= "10011";
	elsif (V = "01110") then
	M <= "10100";
	elsif (V = "01111") then
	M <= "10101";
	elsif (V = "10000") then
	M <= "10110";
	elsif (V = "10001") then
	M <= "10111";
	elsif (V = "10010") then
	M <= "11000";
	else
	M <= "11001";
	end if;
	end process;

end data;

