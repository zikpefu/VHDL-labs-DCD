Library ieee;
USE ieee.std_logic_1164.all;

ENTITY state_machine IS

port(clk, reset, w: IN STD_LOGIC;
		z: OUT STD_LOGIC_VECTOR(3 downto 0));
END state_machine;

ARCHITECTURE behavior OF state_machine  IS
--Create the state machine with state names
TYPE state_machine IS (rst, Full, twothirds, onethird,Empty, Refuel, Walking, Drive_23s, Drive_13s, Drive_Empty);
--Internal signal to connect between the states
SIGNAl y: state_machine;
begin 
process(reset,clk)
begin
--Low active reset
if reset = '0' then
y <= rst;
--Modified vhd file has "and ival = '1'"
elsif rising_edge(clk) then
--Case statment to select the state machine
case y is
--State machine with switch cases to select correct state
when rst => y <= Full;
when Refuel => y <= Full;
when Full =>
	if w = '1' then
	y <= Refuel;
	else
	y <= Drive_23s;
	end if;
when Drive_23s => y <= twothirds;
when twothirds =>
	if w = '1' then
	y <= Refuel;
	else
	y <= Drive_13s;
	end if;
when Drive_13s => y <= onethird;
when onethird =>
	if w = '1' then
	y <= Refuel;
	else
	y <= Drive_Empty;
	end if;
when Drive_Empty => y <= Empty;
when Empty => y <= Walking;
when Walking => y <= onethird;
when others => y <= Full;
end case;
end if;
end process;
--Output select case for y
z <= "0000" when y = rst else 
     "0001" when y = Full else 
     "0010" when y = twothirds else 
     "0111" when y = onethird  else
     "0100" when y = Empty else 
     "1100" when y = Refuel else 
     "1101" when y = Walking else
	  "0101";
END behavior;
