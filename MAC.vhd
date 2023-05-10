-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.systolic_package.all;
USE ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY MAC 
IS PORT(
    A,W,Part : IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
    Sum   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) -- output
);
END MAC;

ARCHITECTURE description OF MAC IS

signal MulOut_16bit : STD_LOGIC_VECTOR (15 downto 0);
signal MulOut_lower8bits : STD_LOGIC_VECTOR (7 downto 0);
signal Mulout_upper8bits : STD_LOGIC_VECTOR (7 downto 0);
signal AddOut: STD_LOGIC_VECTOR (7 DOWNTO 0);


BEGIN
	MulOut_16bit<=STD_LOGIC_VECTOR  (unsigned(A) * unsigned(W));
	MulOut_lower8bits<=MulOut_16bit(7 downto 0);
	MulOut_upper8bits<=MulOut_16bit(15 downto 8);

   
	AddOut<=MulOut_lower8bits+Part;

	process (AddOut)
	begin
		if (AddOut>"11111111") then
			sum<="11111111";
		else 
			sum<=AddOut;
		end if;
	end process;
END description;