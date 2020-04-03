LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity shift_register is
generic(WIDTH: INTEGER := 8);
    Port ( D   : in  STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
			  SHIFT: in STD_LOGIC;
           CLK : in  STD_LOGIC;
           SHIFTED : out STD_LOGIC_VECTOR (WIDTH - 1 downto 0));
end shift_register;

architecture Behavioral of shift_register is
    signal internal_d : STD_LOGIC_VECTOR(WIDTH - 1 downto 0);
begin
    process (CLK)
    begin
        if (rising_edge(CLK) and SHIFT = '1') then
            internal_d(WIDTH - 1 downto 0) <= D;
            internal_d(WIDTH) <= '0';
			else
				internal_d <= internal_d;
        end if;
    end process;
    
    -- hook up the shift register bits to the LEDs
    SHIFTED <= internal_d;

end Behavioral;
