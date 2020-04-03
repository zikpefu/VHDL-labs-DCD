LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity ctrl is
port (
		start_calc: IN std_logic;
		clk: IN std_logic;
		done_flag: in std_logic;
		loadreg: OUT std_logic;
		shiftreg: OUT std_logic;
		count: OUT  std_logic;
		addreg: OUT std_logic;
		busy: OUT std_logic;
		done: OUT std_logic;
		reset: IN std_logic
		);
end ctrl;

architecture dataflow of ctrl is
TYPE cntrlunit IS (start, load, add, shift, finish);
signal y: cntrlunit;
begin 

process(reset, clk)
begin
if reset = '0' then
 y <= start;
elsif rising_edge(clk) then
		case y is
				 when start =>
					 if start_calc = '1' then y <= load;
					 else
					 y <= start;
					 end if;
				 when load => y <= add;
				 when add => y <= shift;
				 when shift =>
					 if done_flag = '1' then y <= finish;
					 else
					 y <= add;
					 end if;
				 when finish => y <= start;
		 end case;
	end if;
end process;

process(y)
begin 
case y is
	when start =>
	busy <= '0';
	loadreg <= '0';
	shiftreg <= '0';
	count <= '0';
	addreg <= '0';
	done <= '0';
	
	when load =>
	busy <= '1';
	loadreg <= '1';
	shiftreg <= '0';
	count <= '0';
	addreg <= '0';
	done <= '0';
	
	when add =>
	busy <= '1';
	loadreg <= '0';
	shiftreg <= '0';
	count <= '1';
	addreg <= '1';
	done <= '0';
	
	when shift =>
	busy <= '1';
	loadreg <= '0';
	shiftreg <= '1';
	count <= '0';
	addreg <= '0';
	done <= '0';
	
	when finish =>
	busy <= '1';
	loadreg <= '0';
	shiftreg <= '0';
	count <= '0';
	addreg <= '0';
	done <= '1';
	end case;
	end process;
end dataflow;