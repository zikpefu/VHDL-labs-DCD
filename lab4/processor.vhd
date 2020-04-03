LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity processor is
generic(WIDTH: INTEGER := 16);
port (	DIN: IN std_logic_vector(WIDTH - 1 downto 0);
			CLK: IN std_logic;
			RUN: IN std_logic;
			RESETN: IN std_logic;
			DATABUS: OUT std_logic_vector(WIDTH - 1 downto 0);
			DONE: OUT std_logic);
end processor;

architecture mixed of processor is
--loads of signals declared here
SIGNAL IR_out: std_logic_vector(7 downto 0);
SIGNAL R0_mux, R1_mux, R2_mux, R3_mux, R4_mux, R5_mux, R6_mux, R7_mux, G_mux, DIN_mux: std_logic;
SIGNAl IR_en, R0_en, R1_en, R2_en, R3_en, R4_en, R5_en, R6_en, R7_en, A_en, G_en, sub_line, sig_done: std_logic;
SIGNAL R0_out, R1_out, R2_out, R3_out, R4_out, R5_out, R6_out, R7_out, G_out, A_out, G_in, int_bus: std_logic_vector(WIDTH - 1 downto 0);

COMPONENT reg
generic(WIDTH: INTEGER);
	PORT(databus: IN std_logic_vector(WIDTH - 1 downto 0);
		clk: IN std_logic;
		enable: IN std_logic;
		regout: OUT std_logic_vector(WIDTH - 1 downto 0));
END COMPONENT;

COMPONENT mux
generic(WIDTH: INTEGER);
port (DIN: IN std_logic_vector(WIDTH - 1 downto 0);
		R0: IN std_logic_vector(WIDTH - 1 downto 0);
		R1: IN std_logic_vector(WIDTH - 1 downto 0);
		R2: IN std_logic_vector(WIDTH - 1 downto 0);
		R3: IN std_logic_vector(WIDTH - 1 downto 0);
		R4: IN std_logic_vector(WIDTH - 1 downto 0);
		R5: IN std_logic_vector(WIDTH - 1 downto 0);
		R6: IN std_logic_vector(WIDTH - 1 downto 0);
		R7: IN std_logic_vector(WIDTH - 1 downto 0);
		G: IN std_logic_vector(WIDTH - 1 downto 0);
		sel_lines: IN std_logic_vector(9 downto 0);
		output: OUT std_logic_vector(WIDTH - 1 downto 0));
END COMPONENT;

COMPONENT addsuber
generic(WIDTH: INTEGER);
port (areg: IN std_logic_vector(WIDTH - 1 downto 0);
		databus: IN std_logic_vector(WIDTH - 1 downto 0);
		addorsub: IN std_logic;
		output: OUT std_logic_vector(WIDTH - 1 downto 0));
END COMPONENT;

COMPONENT cntrlunit
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
END COMPONENT;
begin
--Port map all signal and componets together to form the processor
fsm: cntrlunit
port map (
run => RUN,
reset => RESETN,
clk => CLK,
iroutput => IR_out,
reg_output_line(9) => DIN_mux,
reg_output_line(8) => G_mux,
reg_output_line(7) => R7_mux,
reg_output_line(6) => R6_mux,
reg_output_line(5) => R5_mux,
reg_output_line(4) => R4_mux,
reg_output_line(3) => R3_mux,
reg_output_line(2) => R2_mux,
reg_output_line(1) => R1_mux,
reg_output_line(0) => R0_mux,
reg_input_line(9) => A_en,
reg_input_line(8) => G_en,
reg_input_line(7) => R7_en,
reg_input_line(6) => R6_en,
reg_input_line(5) => R5_en,
reg_input_line(4) => R4_en,
reg_input_line(3) => R3_en,
reg_input_line(2) => R2_en,
reg_input_line(1) => R1_en,
reg_input_line(0) => R0_en,
addorsub => sub_line,
done => sig_done,
irinput => IR_en
);
reg0: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => R0_en,
	regout => R0_out
);
reg1: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => R1_en,
	regout => R1_out
);
reg2: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => R2_en,
	regout => R2_out
);
reg3: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => R3_en,
	regout => R3_out
);
reg4: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => R4_en,
	regout => R4_out
);

reg5: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => R5_en,
	regout => R5_out
);
reg6: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => R6_en,
	regout => R6_out
);
reg7: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => R7_en,
	regout => R7_out
);
regA: reg
generic map(WIDTH => WIDTH)
port map(
	databus => int_bus,
	clk => CLK,
	enable => A_en, 
	regout => A_out
	);
regG : reg
generic map(WIDTH => WIDTH)
port map(
	databus => G_in,
	clk => CLK,
	enable => G_en,
	regout => G_out
	);

IR: reg
generic map(WIDTH => 8)
port map(
	databus => DIN(7 downto 0),
	clk => CLK,
	enable => IR_en,
	regout => IR_out
);
multiplex: mux
generic map(WIDTH => WIDTH)
port map(
	DIN => DIN,
	R0 => R0_out,
	R1 => R1_out,
	R2 => R2_out,
	R3 => R3_out,
	R4 => R4_out,
	R5 => R5_out,
	R6 => R6_out,
	R7 => R7_out,
	G => G_out,
	sel_lines(9) => DIN_mux,
	sel_lines(8) => G_mux,
	sel_lines(7) => R7_mux,
	sel_lines(6) => R6_mux,
	sel_lines(5) => R5_mux,
	sel_lines(4) => R4_mux,
	sel_lines(3) => R3_mux,
	sel_lines(2) => R2_mux,
	sel_lines(1) => R1_mux,
	sel_lines(0) => R0_mux,
	output => int_bus
);

arithmetic: addsuber
generic map(WIDTH => WIDTH)
port map(
areg => A_out,
databus => int_bus,
addorsub => sub_line,
output => G_in
);
done <= sig_done;
DATABUS <= int_bus;
end mixed;