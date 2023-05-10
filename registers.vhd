-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY registers 
IS PORT(
      D  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    Ld  : IN STD_LOGIC; -- load/enable.
    reset : IN STD_LOGIC; -- async. reset.
    clk : IN STD_LOGIC; -- clock.
		Q   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) -- output
);
END registers;

ARCHITECTURE description OF registers IS

BEGIN
    process(clk, reset)
    begin
        if reset = '1' then
            Q <= b"00000000";
        elsif rising_edge(clk) then
            if Ld = '1' then
                Q <= D;
            end if;
        end if;
    end process;
END description;