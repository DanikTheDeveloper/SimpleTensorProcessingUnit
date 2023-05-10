-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.systolic_package.all;


ENTITY STPU IS 
PORT(
    clk, reset, hreset, stall : IN STD_LOGIC;--input
	 y : IN STD_LOGIC_VECTOR(23 DOWNTO 0);--input
	 w : IN STD_LOGIC_VECTOR(23 DOWNTO 0);--input
    done : OUT STD_LOGIC; -- output
    row : OUT bus_width
);
END STPU;

ARCHITECTURE description OF STPU IS

signal URAMOUT0 : STD_LOGIC_VECTOR(7 downto 0);
signal URAMOUT1 : STD_LOGIC_VECTOR(7 downto 0);
signal URAMOUT2 : STD_LOGIC_VECTOR(7 downto 0);
signal row0out : STD_LOGIC_VECTOR(7 downto 0);
signal row1out : STD_LOGIC_VECTOR(7 downto 0);
signal row2out : STD_LOGIC_VECTOR(7 downto 0);
signal WRAMOUT : STD_LOGIC_VECTOR(23 downto 0);

component MMU IS 
PORT(
    a0,a1,a2,w0,w1,w2: IN STD_LOGIC_VECTOR(7 DOWNTO 0);--input
	 ld,ld_w,clk,reset,hardReset,stall:IN STD_LOGIC;
    y0,y1,y2  : OUT STD_LOGIC_VECTOR(7 DOWNTO 0) -- output
);
end component;

component ActivationUnit IS 
PORT(
    clk, reset, hreset, stall : IN STD_LOGIC;--input
	 y_in0,y_in1,y_in2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
    done : OUT STD_LOGIC; -- output
    row : OUT bus_width
);
end component;

component WRAM
PORT
(
	aclr		: IN STD_LOGIC  := '0';
	address	: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	clock		: IN STD_LOGIC  := '1';
	data		: IN STD_LOGIC_VECTOR (23 DOWNTO 0);
	rden		: IN STD_LOGIC  := '1';
	wren		: IN STD_LOGIC ;
	q		: OUT STD_LOGIC_VECTOR (23 DOWNTO 0)
);
end component;

component URAM
PORT
(
	aclr		: IN STD_LOGIC  := '0';
	address	: IN STD_LOGIC_VECTOR (1 DOWNTO 0);
	clock		: IN STD_LOGIC  := '1';
	data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	rden		: IN STD_LOGIC  := '1';
	wren		: IN STD_LOGIC ;
	q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
);
end component;

BEGIN
	
	obj0: WRAM
	port map(address=>"00",aclr=>hreset,clock=>clk,wren=>'1',data=>w,q=>WRAMOUT);
	
	obj1: URAM
	port map(address=>"01",aclr=>hreset,clock=>clk,wren=>'1',data=>y(7 downto 0),q=>URAMOUT0);
	
	obj2: URAM
	port map(address=>"10",aclr=>hreset,clock=>clk,wren=>'1',data=>y(15 downto 8),q=>URAMOUT1);
	
	obj3: URAM
	port map(address=>"11",aclr=>hreset,clock=>clk,wren=>'1',data=>y(23 downto 16),q=>URAMOUT2);
	
	obj4: MMU
	port map(a0=>URAMOUT0,a1=>URAMOUT1,a2=>URAMOUT2,w0=>WRAMOUT(7 downto 0),w1=>WRAMOUT(15 downto 8),w2=>WRAMOUT(23 downto 16),ld=>'1',ld_w=>'1',reset=>reset,
				hardReset=>hreset,clk=>clk,stall=>'1',y0=>row0out,y1=>row1out,y2=>row2out);
				
	obj5: ActivationUnit
	port map(clk=>clk,reset=>reset,hreset=>hreset,stall=>stall,y_in0=>row0out,y_in1=>row1out,y_in2=>row2out,done=>done,row=>row);
				
END description;