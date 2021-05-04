----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2021 18:22:38
-- Design Name: 
-- Module Name: mux - Behavioral
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

entity mux is
    Port (
        cnt_i   : in std_logic_vector(2 - 1 downto 0);    -- Select line that determines which input is connected to output
        data0_i : in std_logic_vector(4 - 1 downto 0);    -- 4-bit values of each digit
        data1_i : in std_logic_vector(4 - 1 downto 0);
        data2_i : in std_logic_vector(4 - 1 downto 0);
        data3_i : in std_logic_vector(4 - 1 downto 0);
        hex_o   : out std_logic_vector(4 - 1 downto 0);   -- 4-bit output value for hex_7seg
        dig_o   : out std_logic_vector(4 - 1 downto 0)    -- 4-bit output value that determines individual display
        );
end mux;

architecture Behavioral of mux is

begin
    p_mux : process(cnt_i, data0_i, data1_i, data2_i, data3_i)
    begin
        case cnt_i is
            when "11" =>
                hex_o <= data3_i;
                dig_o <= "0111";

            when "10" =>
                hex_o <= data2_i;
                dig_o <= "1011";

            when "01" =>
                hex_o <= data1_i;
                dig_o <= "1101";

            when others =>
                hex_o <= data0_i;
                dig_o <= "1110";
        end case;
    end process p_mux;

end Behavioral;
