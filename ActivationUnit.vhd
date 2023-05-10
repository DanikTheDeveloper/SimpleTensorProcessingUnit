-- group 4
-- Mojdeh Sana
-- Daniyar Umuraliyev 301385064
LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE work.systolic_package.all;


ENTITY ActivationUnit IS 
PORT(
    clk, reset, hreset, stall : IN STD_LOGIC;--input
	 y_in0,y_in1,y_in2 : IN STD_LOGIC_VECTOR (7 DOWNTO 0);--input
    done : OUT STD_LOGIC; -- output
    row : OUT bus_width
);
END ActivationUnit;

ARCHITECTURE description OF ActivationUnit IS

signal sig_row0 : bus_width ;
signal sig_row1 : bus_width ;
signal sig_row2 : bus_width ;
signal temp_row0 : bus_width ;
signal temp_row1 : bus_width ;
signal temp_row2 : bus_width ;
signal count : STD_LOGIC_VECTOR(3 downto 0);
signal count1 : STD_LOGIC_VECTOR(3 downto 0);
signal dtemp : STD_LOGIC := '0';

BEGIN
	done <= dtemp;
	
	PROCESS(CLK, RESET, hreset)
		BEGIN
		IF(RESET = '1' or hreset = '1') THEN
			count <= "0000";
		ELSIF(RISING_EDGE(CLK)) THEN
			count <= count1;
		END IF;
	END PROCESS;
	
	PROCESS(count)
		BEGIN
		CASE count IS
			WHEN "0000" =>
				count1 <= "0001";
			WHEN "0001" =>
				count1 <= "0010";
			WHEN "0010" =>
				count1 <= "0011";
			WHEN "0011" =>
				count1 <= "0100";
			WHEN "0100" =>
				count1 <= "0101";
			WHEN "0101" =>
				count1 <= "0110";
			WHEN "0110" =>
				count1 <= "0111";
			WHEN "0111" =>
				count1 <= "1000";
			WHEN "1000" =>
				IF(RESET = '1' or hreset = '1') THEN
					dtemp <= '0';
				ELSE
					dtemp <= '1';
				END IF;
				count1 <= "1001";
			WHEN others =>
				count1 <= "0000";
				dtemp <= '0';
		END CASE;
	END PROCESS;
	
	PROCESS(CLK, RESET, hreset)
		BEGIN
		IF(RESET = '1' or HRESET = '1') THEN
			sig_row0 <= ("00000000","00000000","00000000");
			sig_row1 <= ("00000000","00000000","00000000");
			sig_row2 <= ("00000000","00000000","00000000");
		ELSIF(RISING_EDGE(CLK)) THEN
			sig_row0(0) <= y_in0;
			sig_row1(0) <= y_in1;
			sig_row2(0) <= y_in2;
			
			sig_row0(1) <= temp_row0(1);
			sig_row1(1) <= temp_row1(1);
			sig_row2(1) <= temp_row2(1);
			
			sig_row0(2) <= temp_row0(2);
			sig_row1(2) <= temp_row1(2);
			sig_row2(2) <= temp_row2(2);
		END IF;
	END PROCESS;
	
	temp_row0(1) <= sig_row0(0);
	temp_row1(1) <= sig_row1(0);
	temp_row2(1) <= sig_row2(0);
	
	temp_row0(2) <= sig_row0(1);
	temp_row1(2) <= sig_row1(1);
	temp_row2(2) <= sig_row2(1);
	
	PROCESS(dtemp)
		BEGIN
		IF(dtemp = '1') THEN
			row(0)<=sig_row0(0);
			row(1)<=sig_row1(1);
			row(2)<=sig_row2(2);
		END IF;
	END PROCESS;
	
END description;