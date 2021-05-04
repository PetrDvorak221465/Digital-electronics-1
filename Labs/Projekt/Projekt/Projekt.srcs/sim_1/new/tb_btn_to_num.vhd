----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.04.2021 15:13:47
-- Design Name: 
-- Module Name: tb_btn_to_num - Behavioral
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

entity tb_btn_to_num is
--  Port ( );
end tb_btn_to_num;

architecture Behavioral of tb_btn_to_num is
    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;
    
    signal s_clk     :   std_logic;
    signal s_reset   :   std_logic;
    signal s_btn_row :   std_logic_vector(4 - 1 downto 0);
    signal s_btn_col :   std_logic_vector(3 - 1 downto 0);
    signal s_hex_o   :   std_logic_vector(4 - 1 downto 0);
    signal s_key_p_o :   std_logic_vector(3 - 1 downto 0);
    
begin
    uut_btn_to_num : entity work.btn_to_num
            
            port map( -- connecting signals in testbench to btn_to_num entity
              clk     => s_clk,    
              reset   => s_reset,  
              btn_row => s_btn_row,
              btn_col => s_btn_col,
              hex_o   => s_hex_o,
              key_p_o => s_key_p_o
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
               
    p_stimulus : process
    begin
        report "Stimulus process started" severity note; -- data generation process
        s_btn_row <= "1111";
        wait for 200 ns;
      
        s_btn_row <= "0111";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1110";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1110";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
      
        s_btn_row <= "0111";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1101";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "0111";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1101";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        s_btn_row <= "1011";
        wait for 200 ns;
        
        s_btn_row <= "1111";
        wait for 200 ns;
        
        report "Stimulus process finished" severity note;
        wait;
    end process p_stimulus;
end Behavioral;
