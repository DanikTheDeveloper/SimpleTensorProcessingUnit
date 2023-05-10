-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY PE 
IS PORT(
    a_in,w_in,part_in: IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
	 ld,ld_w,clk,reset,hardReset:IN STD_LOGIC;
    partial_sum,a_out  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) -- output
);
END PE;

ARCHITECTURE description OF PE IS

component registers IS 
PORT(
    D  : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
    Ld  : IN STD_LOGIC; -- load/enable.
    reset : IN STD_LOGIC:='0'; -- async. reset.
    clk : IN STD_LOGIC; -- clock.
    Q   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) -- output
);
END component registers;


component MAC IS
PORT(
    A,W,Part : IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
    Sum   : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) -- output
);
END component MAC;



signal regwOut :STD_LOGIC_VECTOR (7 DOWNTO 0);
signal macOut :STD_LOGIC_VECTOR (7 DOWNTO 0);

begin 

RegW: registers
port map (D=>w_in,Ld=>ld_w,reset=>reset,clk=>clk,Q=>regwOut);

RegA: registers
port map (D=>a_in,Ld=>ld, clk=>clk,Q=>a_out);


maccomp: MAC
port map (W=>regwOut,A=>a_in,Part=>part_in,Sum=>macOut);

RegY: registers
port map (D=>macOut,Ld=>ld, clk=>clk,Q=>partial_sum);

END description;




