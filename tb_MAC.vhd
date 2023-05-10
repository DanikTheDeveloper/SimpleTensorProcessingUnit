-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

 
ENTITY tb_MAC IS
END tb_MAC;
 
ARCHITECTURE behavior OF tb_MAC IS
 

 COMPONENT MAC
	PORT(		A,W,Part : IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
				Sum   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0)); -- output
 END COMPONENT;

 signal A,W,Part :  STD_LOGIC_VECTOR (7 DOWNTO 0);
 signal    Sum   :  STD_LOGIC_VECTOR (7 DOWNTO 0) ;


begin
 
DUT: MAC PORT MAP (A=>A,W=>W,Part=>Part,Sum=>Sum);


stim_proc: process
begin        
  
	A<="00000000";
	W<="00000000";
	Part<="00000000";
	wait for 21 ns;
	A<="00000001";
	W<="00000001";
	Part<="00000000";
	wait for 18 ns;
	A<="00000001";
	W<="00000001";
	Part<="00000001";
	wait for 20 ns;
	A<="00000010";
	W<="00000010";
	Part<="00000000";
	wait for 23 ns;
	A<="00000010";
	W<="00000010";
	Part<="00000000";
	wait for 17 ns;
	A<="00000010";
	W<="00000010";
	Part<="00000001";
	wait for 21 ns;
	A<="00000100";
	W<="00000001";
	Part<="00000001";
	wait for 20 ns;
end process;
end behavior;