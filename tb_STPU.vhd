-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.systolic_package.all;
 
ENTITY tb_STPU IS
END tb_STPU;
 
ARCHITECTURE behavior OF tb_STPU IS
 

 COMPONENT STPU
PORT(
    clk, reset, hreset, stall : IN STD_LOGIC;--input
	 y,w : IN STD_LOGIC_VECTOR(23 DOWNTO 0);--input
    done : OUT STD_LOGIC; -- output
    row : OUT bus_width); -- output
 END COMPONENT;


signal clk, reset, hreset, stall : STD_LOGIC;
signal y,w : STD_LOGIC_VECTOR(23 DOWNTO 0);
signal done :  STD_LOGIC; 
signal row : bus_width; 

begin
 
DUT: STPU PORT MAP (w=>w,stall=>stall,reset=>reset,hreset=>hreset,clk=> clk,row=> row,y=>y,done=>done);
 
 clock_process :process
begin
     clk <= '0';
     wait for 100 ns;
     clk <= '1';
     wait for 100 ns;
end process;


stim_proc: process
begin        
	reset <='0';
	hreset <= '0';
	stall <= '1';
	y<="111111111111111111111111";
	w<="000000000000000000000000";
   wait for 1951 ns;
	y<="111111111000111000111000";
	w<="111000000000000000000111";
	wait for 1898 ns;
	y<="111000111000111000111000";
	w<="000000000000000000000000";
   wait for 1855 ns;
	y<="000000000000000000000000";
	w<="111111111111111111111111";
   wait for 1916 ns;
	y<="000000000000000000000000";
	w<="000000000000000000000000";
   wait for 1900 ns;
	y<="000000000111111111111111";
	w<="111111111111111000000000";
   wait for 1918 ns;
	wait;
end process;
end behavior;