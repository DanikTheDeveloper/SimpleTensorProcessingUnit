-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;


ENTITY MMU 
IS PORT(
    a0,a1,a2,w0,w1,w2: IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
	 ld,ld_w,clk,reset,hardReset,stall:IN STD_LOGIC;
    y0,y1,y2  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) -- output
);
END MMU;

ARCHITECTURE description OF MMU IS
component PE IS PORT(
    a_in,part_in, w_in: IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
	 ld,ld_w,clk,reset,hardReset:IN STD_LOGIC;
    partial_sum,a_out  : OUT STD_LOGIC_VECTOR (7 DOWNTO 0) -- output
);
END component PE;

signal asig11,asig12,asig21,asig22,asig31,asig32 :STD_LOGIC_VECTOR (7 DOWNTO 0);
signal psig11,psig12,psig13,psig21,psig22,psig23 :STD_LOGIC_VECTOR (7 DOWNTO 0);
signal weight0,weight1,weight2 :STD_LOGIC_VECTOR (7 DOWNTO 0);
signal a0sig,a1sig,a2sig :STD_LOGIC_VECTOR (7 DOWNTO 0);

TYPE State_type IS (idle, load_col0, load_col1,load_col2 );  
	SIGNAL State : State_Type;    
							      
BEGIN 
  PROCESS (clk, reset, hardReset) 
  BEGIN 
    
	 if (reset = '1' or hardReset='1') THEN            
	State <= idle;
	
 
    ELSIF rising_edge(clk) THEN    
		
		
	CASE State IS
 
	
		WHEN idle =>
			IF ld_w='1' THEN 
	weight0<=w0;
	weight1<=w1;
	weight2<=w2;		
	State <=load_col0 ; 
			END IF; 
 
		
		WHEN load_col0 => 
			IF ld_w='1' THEN 
			
			
	weight0<=w0;
	weight1<=w1;
	weight2<=w2;
	State <= load_col1; 
			END IF; 
 
		
		WHEN load_col1 => 
			IF ld_w='1' THEN 
				
	weight0<=w0;
	weight1<=w1;
	weight2<=w2;
	State <=load_col2 ; 
			END IF; 
 
		WHEN load_col2 =>
	
	weight0<=(others=>'0');
	weight1<=(others=>'0');
	weight2<=(others=>'0');
			
			State <= idle;
	END CASE; 
    END IF; 
  END PROCESS;

 PROCESS (clk) 
  BEGIN 
	IF rising_edge(clk) THEN  
		 IF (ld='1') THEN
  			
	a0sig<=a0;
	a1sig<=a1;
	a2sig<=a2;
	END IF;
		END IF;
	END PROCESS;

comp11: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>a0sig,a_out=>asig11,part_in=>(others=>'0'),partial_sum=>psig11,w_in=>weight0);

comp12: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>asig11,a_out=>asig12,part_in=>(others=>'0'),partial_sum=>psig12,w_in=>weight0);

comp13: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>asig12,part_in=>(others=>'0'),partial_sum=>psig13,w_in=>weight0);

comp21: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>a1sig,a_out=>asig21,part_in=>psig11,partial_sum=>psig21,w_in=>weight1);

comp22: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>asig21,a_out=>asig22,part_in=>psig12,partial_sum=>psig22,w_in=>weight1);

comp23: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>asig22,part_in=>psig13,partial_sum=>psig23,w_in=>weight1);

comp31: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>a2sig,a_out=>asig31,part_in=>psig21,partial_sum=>y0,w_in=>weight2);

comp32: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>asig31,a_out=>asig32,part_in=>psig22,partial_sum=>y1,w_in=>weight2);

comp33: PE
port map(clk=>clk,ld=>'1',ld_w=>'1',reset=>reset,hardreset=>hardreset,a_in=>asig32,part_in=>psig23,partial_sum=>y2,w_in=>weight2);
  
end description;

