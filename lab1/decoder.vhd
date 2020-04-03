LIBRARY ieee;
USE ieee.std_logic_1164.all;


entity decoder is
port( M: IN STD_LOGIC_VECTOR(4 DOWNTO 0);
		HEX1: OUT STD_LOGIC_VECTOR(6 DOWNTO 0);
		HEX2: OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
end decoder;

--BCD Codes from 0 to 9
--0 1000000
--1 1111001
--2 0100100
--3 0110000
--4 0011001
--5 0010010
--6 0000010
--7 1111000
--8 0000000
--9 0011000
architecture behave of decoder is
begin
	process(M)
	begin
	if(M < "10000") then
	--If M is less than 10 display a 0
	HEX2 <= "1000000";
	else 
	--If M is greater than 10 display a 1
	HEX2 <= "1111001";
	end if;
	--Develop if statements to decode the value of M to the HEX1
	--If the number is greater than 9 restart count from 0
	if (M = "00000" OR M = "10000") then
	HEX1 <= "1000000";
	elsif (M = "00001" OR M = "10001") then
	HEX1 <= "1111001";
	elsif (M = "00010" OR M = "10010") then
	HEX1 <= "0100100";
	elsif (M = "00011" OR M = "10011") then
	HEX1 <= "0110000";
	elsif (M = "00100" OR M = "10100") then
	HEX1 <= "0011001";
	elsif (M = "00101" OR M = "10101") then
	HEX1 <= "0010010";
	elsif (M = "00110" OR M = "10110") then
	HEX1 <= "0000010";
	elsif (M = "00111" OR M = "10111") then
	HEX1 <= "1111000";
	elsif (M = "01000" OR M = "11000") then
	HEX1 <= "0000000";
	elsif (M = "01001" OR M = "11001") then
	HEX1 <= "0011000";
	else
	HEX1 <= "0111111";
	end if;
	end process;

end behave;

