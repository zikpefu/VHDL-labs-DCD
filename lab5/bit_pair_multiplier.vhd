LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity bit_pair_multiplier is
generic(WIDTH: INTEGER := 4);
port (	MULTIPLICAND: IN std_logic_vector(WIDTH - 1 downto 0);
			MULTIPLIER: IN std_logic_vector(WIDTH - 1 downto 0);
			START: IN std_logic;
			CLK: IN std_logic;
			RESETN: IN std_logic;
			DONE: OUT std_logic;
			BUSY: OUT std_logic;
			PRODUCT: OUT std_logic_vector((WIDTH * 2) - 1 downto 0)
			);
end bit_pair_multiplier;

architecture mixed of bit_pair_multiplier is
--loads of signals declared here
SIGNAL sig_done, load_sig, add_sig, cnt_sig, shift_sig, finish_sig, busy_sig: std_logic;
SIGNAL select_lines: std_logic_vector(2 downto 0);
SIGNAL c_shift_sig: std_logic_vector(1 downto 0);
SIGNAL one_sig, two_sig, negone_sig, negtwo_sig, big_mux_out, small_mux_out, adder_out, section_1: std_logic_vector(WIDTH downto 0);
SIGNAl half_bits_vector: std_logic_vector((WIDTH / 2) - 1 downto 0);
SIGNAL section_2: std_logic_vector(WIDTH - 1 downto 0);

COMPONENT regA
generic(WIDTH: INTEGER);
port (multiplicand: IN std_logic_vector(WIDTH - 1 downto 0);
		loadreg: IN std_logic;
		clk: IN std_logic;
		regout_2: OUT std_logic_vector(WIDTH downto 0); --1100 --> 1000 <- WRONG : 11000 <- RIGHT!
		regout_neg2: OUT std_logic_vector(WIDTH downto 0);
		regout_1: OUT std_logic_vector(WIDTH downto 0);
		regout_neg1: OUT std_logic_vector(WIDTH downto 0));
end COMPONENT;

COMPONENT regB
generic(WIDTH: INTEGER);
port (multiplier: in std_logic_vector(WIDTH - 1 downto 0);
		loadreg: in std_logic;
		shift: in std_logic;
		c_input: in std_logic_vector(1 downto 0);
		product: out std_logic_vector(WIDTH - 1 downto 0);
		sel_line: out std_logic_vector(2 downto 0);
		clk: in std_logic
);
end COMPONENT;

COMPONENT regC
generic(WIDTH: INTEGER);
--input/output
port (input: in std_logic_vector(WIDTH downto 0);
		shift: in std_logic;
		load_reg: in std_logic;
		add_reg: in std_logic;
		shift_out: out std_logic_vector(1 downto 0);
		output: out std_logic_vector(WIDTH downto 0);
		clk: in std_logic
);
end COMPONENT;

COMPONENT regD
generic(WIDTH: INTEGER);
port (halfbits: in std_logic_vector(WIDTH - 1 downto 0);
		loadreg: in std_logic;
		count: in std_logic;
		finished: out std_logic;
		clk: in std_logic
);
end COMPONENT;

COMPONENT small_mux
generic(WIDTH: INTEGER);
port (in_adder: in std_logic_vector(WIDTH downto 0);
		output: out std_logic_vector(WIDTH downto 0);
		sel_lines: in std_logic
);
end COMPONENT;

COMPONENT adder
generic(WIDTH: INTEGER);
port (A: IN std_logic_vector(WIDTH downto 0);
		B: IN std_logic_vector(WIDTH downto 0);
		SUM: OUT std_logic_vector(WIDTH downto 0)
);
end COMPONENT;

COMPONENT mux
generic(WIDTH: INTEGER);
port (two: in std_logic_vector(WIDTH downto 0);
		negtwo: in std_logic_vector(WIDTH downto 0);
		one: in std_logic_vector(WIDTH downto 0);
		negone: in std_logic_vector(WIDTH downto 0);
		output: out std_logic_vector(WIDTH downto 0);
		sel_lines: in std_logic_vector(2 downto 0)
);
end COMPONENT;

COMPONENT ctrl
port (
		start_calc: IN std_logic;
		clk: IN std_logic;
		done_flag: IN std_logic;
		reset: IN std_logic;
		loadreg: OUT std_logic;
		shiftreg: OUT std_logic;
		count: OUT  std_logic;
		addreg: OUT std_logic;
		busy: OUT std_logic;
		done: OUT std_logic
		);
end COMPONENT;
begin

half_bits_vector <= ('1', others => '0');
--Port map all signal and componets together to form the processor
fsm: ctrl
port map (
	start_calc => START,
	reset => RESETN,
	clk => CLK,
	done => sig_done,
	done_flag => finish_sig,
	loadreg => load_sig,
	shiftreg => shift_sig,
	count => cnt_sig,
	addreg => add_sig,
	busy => busy_sig
);

registerA: regA
generic map(WIDTH => WIDTH)
port map(
	multiplicand => MULTIPLICAND,
	loadreg => load_sig,
	clk => CLK,
	regout_2 => two_sig,
	regout_1 => one_sig,
	regout_neg1 => negone_sig,
	regout_neg2 => negtwo_sig
);

registerB: regB
generic map(WIDTH => WIDTH)
port map(
	multiplier => MULTIPLIER,
	loadreg => load_sig,
	shift => shift_sig,
	c_input => c_shift_sig,
	product => section_2,
	clk => CLK,
	sel_line => select_lines
);
registerC: regC
generic map(WIDTH => WIDTH)
port map(
	input => small_mux_out,
	shift => shift_sig,
	load_reg => load_sig,
	add_reg => add_sig,
	shift_out => c_shift_sig,
	output => section_1,
	clk => CLK
);
registerD: regD
generic map(WIDTH => WIDTH / 2)
port map(
	halfbits => half_bits_vector,
	loadreg => load_sig,
	count => cnt_sig,
	finished => finish_sig,
	clk => CLK
);

bigger_mux: mux
generic map(WIDTH => WIDTH)
port map(
	two => two_sig,
	negtwo => negtwo_sig,
	one => one_sig,
	negone => negone_sig,
	output => big_mux_out,
	sel_lines => select_lines
);

smaller_mux: small_mux
generic map(WIDTH => WIDTH)
port map(
	in_adder => adder_out,
	output => small_mux_out,
	sel_lines => load_sig
);

arithmetic: adder
generic map(WIDTH => WIDTH)
port map(
A => section_1,
B => big_mux_out,
SUM => adder_out
);

DONE <= sig_done;
BUSY <= busy_sig;
PRODUCT((WIDTH * 2)- 1 downto WIDTH)<= section_1(WIDTH downto 1);
PRODUCT(WIDTH - 1 downto 0) <= section_2;
end mixed;