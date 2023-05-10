-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.systolic_package.all;

 
ENTITY tb_ActivationUnit IS
END tb_ActivationUnit;
 
ARCHITECTURE behavior OF tb_ActivationUnit IS
 

 COMPONENT ActivationUnit
PORT(
    clk, reset, hreset, stall : IN STD_LOGIC;--input
	 y_in0,y_in1,y_in2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
    done : OUT STD_LOGIC; -- output
    row : OUT bus_width);
END COMPONENT;
 
signal clk, reset, hreset, stall : STD_LOGIC;--input
signal	 y_in0,y_in1,y_in2 : STD_LOGIC_VECTOR (7 DOWNTO 0);--input
signal   done : STD_LOGIC; -- output
signal row : bus_width; -- output

begin

DUT: ActivationUnit PORT MAP (stall=>stall,reset=>reset,hreset=>hreset,clk=> clk,row=>row,y_in0=>y_in0,y_in1=>y_in1,y_in2=>y_in2,done=>done);
 
 
clock_process :process
begin
     clk <= '0';
     wait for 100 ns;
     clk <= '1';
     wait for 100 ns;
end process;


stim_proc: process
begin        
   reset <= '0';
	hreset <= '0';
	stall <= '1';
	y_in0<="00000001";
   wait for 323 ns;
	y_in1<="00000010";
   wait for 355 ns;
	y_in2<="00000100";
   wait for 300 ns;
	y_in0<="00000001";
   wait for 289 ns;
	y_in1<="10000000";
   wait for 314 ns;
	y_in2<="00000001";
   wait for 324 ns;
	y_in0<="00001000";
   wait for 278 ns;
	y_in1<="00000001";
   wait for 337 ns;
	y_in2<="00010001";
   wait for 300 ns;
	wait;
end process;
end behavior;