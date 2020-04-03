LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity cntrlunit is
port (
		run: IN std_logic;
		reset: IN std_logic;
		clk: IN std_logic;
		iroutput: IN std_logic_vector(7 downto 0);
		reg_output_line: OUT std_logic_vector(9 downto 0);
		reg_input_line: OUT std_logic_vector(9 downto 0);
		addorsub: OUT std_logic;
		done: OUT std_logic;
		irinput: OUT std_logic
		);
end cntrlunit;

architecture dataflow of cntrlunit is
TYPE cntrlunit IS (t0, t1, t2, t3);
signal y: cntrlunit;
begin

process(reset, clk)
begin
	if reset = '0' then
	y <= t0;
	elsif rising_edge(clk) then
	case y is
		when t0 =>
			if run = '1' then y <= t1;
			end if;
		when t1 =>
			if iroutput(7 downto 6) = "10" OR iroutput(7 downto 6) = "11" then y <= t2;
			else
			y <= t0;
			end if;
		when t2 => y <= t3;
		when t3 => y <= t0;
	end case;
	end if;
end process;

process(y, iroutput)
--iroutput(2 downto 0) is the y
--iroutput(5 downto 3) is the x 
--reg_output_line is the output to mux
--reg_input_line is to the register enables 
--Using the chart, if mentioned select '1' otherwise '0' 
begin
	case y is
		when t0 =>
		--only IRin is asserted
			irinput <= '1';
			--If DIN needs to be set, put others 1
			reg_output_line <= (others => '0');
			reg_input_line <= (others => '0');
			addorsub <= '0';
			done <= '0';
			
		when t1 =>
			if iroutput(7 downto 6) = "00" then
				irinput <= '0';
				--Select from y
				case iroutput(2 downto 0) is 
				when "000" => reg_output_line <= "0000000001";
				when "001" => reg_output_line <= "0000000010";
				when "010" => reg_output_line <= "0000000100";
				when "011" => reg_output_line <= "0000001000";
				when "100" => reg_output_line <= "0000010000";
				when "101" => reg_output_line <= "0000100000";
				when "110" => reg_output_line <= "0001000000";
				when "111" => reg_output_line <= "0010000000";
				when others => reg_output_line <="0100000000";
				end case;

				case iroutput(5 downto 3) is 
				when "000" => reg_input_line <= "0000000001";
				when "001" => reg_input_line <= "0000000010";
				when "010" => reg_input_line <= "0000000100";
				when "011" => reg_input_line <= "0000001000";
				when "100" => reg_input_line <= "0000010000";
				when "101" => reg_input_line <= "0000100000";
				when "110" => reg_input_line <= "0001000000";
				when "111" => reg_input_line <= "0010000000";
				when others => reg_input_line <= "0100000000";
				end case;
				addorsub <= '0';
				done <= '1';
				elsif iroutput(7 downto 6) = "01" then
				--DIN_output
				reg_output_line <= "1000000000";
				case iroutput(5 downto 3) is 
				when "000" => reg_input_line <= "0000000001";
				when "001" => reg_input_line <= "0000000010";
				when "010" => reg_input_line <= "0000000100";
				when "011" => reg_input_line <= "0000001000";
				when "100" => reg_input_line <= "0000010000";
				when "101" => reg_input_line <= "0000100000";
				when "110" => reg_input_line <= "0001000000";
				when "111" => reg_input_line <= "0010000000";
				when others => reg_input_line <= "0100000000";
				end case;
				done <= '1';
				addorsub <= '0';
				irinput <= '0';
				else
				case iroutput(5 downto 3) is
				when "000" => reg_output_line <= "0000000001";
				when "001" => reg_output_line <= "0000000010";
				when "010" => reg_output_line <= "0000000100";
				when "011" => reg_output_line <= "0000001000";
				when "100" => reg_output_line <= "0000010000";
				when "101" => reg_output_line <= "0000100000";
				when "110" => reg_output_line <= "0001000000";
				when "111" => reg_output_line <= "0010000000";
				when others => reg_output_line <= "0100000000";
				end case;
				--A_in
				reg_input_line <= "1000000000";
				done <= '0';
				addorsub <= '0';
				irinput <= '0';
				end if;
				when t2 =>
				done <= '0';
				irinput <= '0';
				case iroutput(2 downto 0) is
				when "000" => reg_output_line <= "0000000001";
				when "001" => reg_output_line <= "0000000010";
				when "010" => reg_output_line <= "0000000100";
				when "011" => reg_output_line <= "0000001000";
				when "100" => reg_output_line <= "0000010000";
				when "101" => reg_output_line <= "0000100000";
				when "110" => reg_output_line <= "0001000000";
				when "111" => reg_output_line <= "0010000000";
				when others => reg_output_line <= "0100000000";
				end case;
				--G_in
				reg_input_line  <= "0100000000";
				if iroutput(7 downto 6) = "10" then 
				addorsub <= '0';
				else
					addorsub <= '1';
				end if;
				when t3 =>
				reg_output_line  <= "0100000000";
				case iroutput(5 downto 3) is 
				when "000" => reg_input_line <= "0000000001";
				when "001" => reg_input_line <= "0000000010";
				when "010" => reg_input_line <= "0000000100";
				when "011" => reg_input_line <= "0000001000";
				when "100" => reg_input_line <= "0000010000";
				when "101" => reg_input_line <= "0000100000";
				when "110" => reg_input_line <= "0001000000";
				when "111" => reg_input_line <= "0010000000";
				when others => reg_input_line <= "0100000000";
				end case;
				addorsub <= '0';
				irinput <= '0';
				done <= '1';
				end case;
				end process;
end dataflow;