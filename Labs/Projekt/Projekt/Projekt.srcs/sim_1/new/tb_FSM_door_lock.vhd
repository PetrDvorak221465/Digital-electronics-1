----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 18:44:00
-- Design Name: 
-- Module Name: tb_FSM_door_lock - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_FSM_door_lock is
--  Port ( );
end tb_FSM_door_lock;

architecture Behavioral of tb_FSM_door_lock is

     constant c_CLK_100MHZ_PERIOD : time    := 10 ns;                 
     
     signal  s_clk     : std_logic;
     signal  s_arst    : std_logic;
     signal  s_digit_i : std_logic_vector(4 - 1 downto 0); -- Input value from keypad
     signal  s_cnp_i   : std_logic_vector(3 - 1 downto 0); 
     signal  s_relay_o : std_logic;                        
     signal  s_data0_o : std_logic_vector(4 - 1 downto 0);
     signal  s_data1_o : std_logic_vector(4 - 1 downto 0);
     signal  s_data2_o : std_logic_vector(4 - 1 downto 0);
     signal  s_data3_o : std_logic_vector(4 - 1 downto 0);
     signal  s_led_o : std_logic_vector(3 - 1 downto 0);
 
begin

    uut_dls : entity work.dls
            
            port map(
                clk     => s_clk,    
                arst    => s_arst,   
                digit_i => s_digit_i,
                cnp_i   => s_cnp_i,  
                relay_o => s_relay_o,
                data0_o => s_data0_o,
                data1_o => s_data1_o,
                data2_o => s_data2_o,
                data3_o => s_data3_o,
                led_o   => s_led_o
            );
   --Clock generation process--  
    p_clk_gen : process
       begin
           while now < 1000 ns loop
               s_clk <= '0';
               wait for c_CLK_100MHZ_PERIOD / 2;
               s_clk <= '1';
               wait for c_CLK_100MHZ_PERIOD / 2;
           end loop;
           wait;
       end process p_clk_gen;
                  
    p_reset_gen : process
        begin
            s_arst <= '0';
           
    
            wait;
        end process p_reset_gen;
   
   --Data generation process--    
    p_stimulus : process         
    begin
        report "Stimulus process started" severity note;
        
        s_cnp_i <= "000";   
        s_digit_i <= "0001";
        wait for 50 ns;    
        
        s_cnp_i <= "001";     
        s_digit_i <= "0010";  
        wait for 50 ns;      
                        
        s_cnp_i <= "010";     
        s_digit_i <= "0011";  
        wait for 50 ns;
        
        s_cnp_i <= "011";     
        s_digit_i <= "0100";  
        wait for 50 ns;      
                      
        s_cnp_i <= "100";     
        s_digit_i <= "1100";
        wait for 50 ns;
        

        
        s_cnp_i <= "000";
        s_digit_i <= "0001";
        wait for 50 ns;
        
        s_cnp_i <= "001";   
        s_digit_i <= "0010";
        wait for 50 ns;
        
        s_cnp_i <= "010";       
        s_digit_i <= "0011";
        wait for 50 ns;    
        
        s_cnp_i <= "011";   
        s_digit_i <= "0100";
        wait for 50 ns;    
        
        s_cnp_i <= "100";   
        s_digit_i <= "1010";
        wait for 200 ns;    
          
          
          
        s_cnp_i <= "000";
        s_digit_i <= "0000";
        wait for 50 ns;  
          
          
        s_cnp_i <= "000";
        s_digit_i <= "0001";
        wait for 50 ns;
        
        s_cnp_i <= "001";   
        s_digit_i <= "0010";
        wait for 50 ns;
        
        s_cnp_i <= "010";       
        s_digit_i <= "0110";
        wait for 50 ns;    
        
        s_cnp_i <= "011";   
        s_digit_i <= "0101";
        wait for 50 ns;    
        
        s_cnp_i <= "100";   
        s_digit_i <= "0011";
        wait for 50 ns;    
            
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end Behavioral;