----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.05.2021 18:23:26
-- Design Name: 
-- Module Name: tb_door_lock_system - Behavioral
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

entity tb_door_lock_system is
--  Port ( );
end tb_door_lock_system;

architecture Behavioral of tb_door_lock_system is
        constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
        
        signal s_clk     : std_logic;                           -- Main clock
        signal s_reset   : std_logic;                           -- Synchronous reset 
        signal s_btn_row : std_logic_vector(4 - 1 downto 0); -- Input from keypad button rows
        signal s_seg_o   : std_logic_vector(7 - 1 downto 0);    -- Cathode values for individual segments
        signal s_dig_o   : std_logic_vector(4 - 1 downto 0);     -- Common anode signals to individual displays
        signal s_btn_col : std_logic_vector(3 - 1 downto 0); -- Output for keypad button columns
        signal s_relay_o : std_logic;                       -- Relay output (I/O) 
        signal s_led_o   : std_logic_vector(3 - 1 downto 0);
begin
uut_door_lock_system : entity work.door_lock_system
            
            port map( -- connecting signals in testbench to btn_to_num entity
              clk     => s_clk,    
              reset   => s_reset,  
              btn_row => s_btn_row, 
              seg_o   => s_seg_o,   
              dig_o   => s_dig_o,  
              btn_col => s_btn_col, 
              relay_o => s_relay_o,
              led_o   => s_led_o,
              cnt_up_i=> '1'   
            );
p_clk_gen : process -- clock period generation process
    begin
        while now < 4200 ns loop
            s_clk <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;
    
p_reset_gen : process
      begin
          s_reset <= '1';
          wait for 20 ns;
          s_reset <= '0'; 
    
          wait;
      end process p_reset_gen;
   

p_stimulus : process
    begin
        report "Stimulus process started" severity note; -- data generation process
        s_btn_row <= "1111";
        wait for 200 ns;
      
        s_btn_row <= "1101";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "0111";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1101";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1101";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
      
        s_btn_row <= "1101";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "0111";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1101";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1101";
        wait for 200 ns;
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;

end Behavioral;
