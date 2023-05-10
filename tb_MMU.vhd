-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.systolic_package.all;
 
ENTITY tb_MMU IS
END tb_MMU;
 
ARCHITECTURE behavior OF tb_MMU IS
 

 COMPONENT MMU
	PORT(		a0,a1,a2,w0,w1,w2: IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
	 ld,ld_w,clk,reset,hardReset,stall:IN STD_LOGIC;
    y0,y1,y2  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
 END COMPONENT;
 
signal a0,a1,a2,w0,w1,w2:  STD_LOGIC_VECTOR (7 DOWNTO 0);
signal ld,ld_w,clk,reset,hardReset,stall:STD_LOGIC;
signal y0,y1,y2  :  STD_LOGIC_VECTOR (7 DOWNTO 0); -- output

begin
 
DUT: MMU PORT MAP (stall=>stall,reset=>reset,hardReset=>hardReset,clk=> clk,ld=> ld,ld_w=>ld_w,a0=>a0,a1=>a1,a2=>a2,w0=>w0,w1=>w1,w2=>w2,y0=>y0,y1=>y1,y2=>y2);
 
 clock_process :process
begin
     clk <= '0';
     wait for 10 ns;
     clk <= '1';
     wait for 10 ns;
end process;


stim_proc: process
begin        
   ld_w<='1';
	ld<='1';
	reset <='0';
	hardreset <= '0';
	stall <= '1';
	a0<="00000001";
   wait for 20 ns;
	a1<="00000010";
	wait for 20 ns;
	a2<="00000100";
   wait for 20 ns;
	w0<="00001000";
   wait for 20 ns;
	w1<="00010000";
   wait for 20 ns;
	w2<="00100000";
   wait for 20 ns;
	wait;
end process;
end behavior;