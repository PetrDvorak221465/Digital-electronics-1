----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.04.2021 16:47:07
-- Design Name: 
-- Module Name: btn_to_num - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity btn_to_num is
    Port (
            clk     :   in std_logic; -- clock input
            reset   :   in std_logic; -- reset input
            btn_row :   in  std_logic_vector(4 - 1 downto 0); -- Input from keypad button rows
            btn_col :   out std_logic_vector(3 - 1 downto 0); -- Output for keypad button columns
            hex_o   :   out std_logic_vector(4 - 1 downto 0); -- Output carrying the value of the keypad button
            key_p_o :   out std_logic_vector(3 - 1 downto 0)  -- Output carrying position of pressed button
         );
end btn_to_num;

architecture Behavioral of btn_to_num is

     -- Local counter
    signal s_cnt_local  : natural; -- count looping from zero to two
    signal s_key_local  : natural; -- counting position of pressed key
    signal pressed      : std_logic; -- 1 bit value

begin
    
    p_read : process(clk) -- process of btn_to_num converting outputs from keypad to 4 bit binary number hex_o
    begin
    if rising_edge(clk) then
            
        case s_cnt_local is -- every case of s_cnt_local will assign 3 bit value to keypad output and then chcecks keypad input
                            -- then it assigns this input to 4 bit output hex_o
        
            when 0 =>
            btn_col <= "011";
                case btn_row is
                    when "0111" =>
                        hex_o <= "0001"; -- 1;
                    when "1011" =>
                        hex_o <= "0100"; -- 4;
                    when "1101" =>
                        hex_o <= "0111"; -- 7;
                    when "1110" =>
                        hex_o <= "1010"; -- 10 = *;
                    when others =>
                end case;
                
            when 1 =>
            btn_col <= "101";
                case btn_row is
                    when "0111" =>
                        hex_o <= "0010"; -- 2;
                    when "1011" =>
                        hex_o <= "0101"; -- 5;
                    when "1101" =>
                        hex_o <= "1000"; -- 8;
                    when "1110" =>
                        hex_o <= "0000"; -- 0 = 0;
                    when others =>
                end case;
                
            when 2 =>
            btn_col <= "110";
                case btn_row is
                    when "0111" =>
                        hex_o <= "0011"; -- 3;
                    when "1011" =>
                        hex_o <= "0110"; -- 6;
                    when "1101" =>
                        hex_o <= "1001"; -- 9;
                    when "1110" =>
                        hex_o <= "1100"; -- 12 = #;
                    when others =>
                        
                end case;
            when others =>
                hex_o <= "0000";
        end case;
        
        case s_key_local is -- assigns the counter of key position to 3 bit output
            when 1 =>
                key_p_o <= "000";
            when 2 =>
                key_p_o <= "001";
            when 3 =>
                key_p_o <= "010";
            when 4 =>
                key_p_o <= "011";
            when 5 =>
                key_p_o <= "100";
            when others =>
        end case;
        
        if(s_cnt_local = 2 and btn_row = "1110") then -- occurs when # is pressed and resets the key position counter
             s_key_local <= 1;
        end if;
        
        if (btn_row /= "1111") then -- occurs when key is pressed
            if(pressed = '0') then -- ensures that code will run only once after pressing key
                pressed <= '1';
                if(s_key_local >= 5) then -- resets key position counter
                    s_key_local <= 1;
                else
                    s_key_local <= s_key_local + 1;
                end if;
            end if;
        else -- when no key is pressed
            pressed <= '0'; -- resets the key pressed value for next time key is pressed
            if (reset = '1' or s_cnt_local >= 2) then  -- counting from 0 to 2 for the btn_col output
                s_cnt_local <= 0;
            else
                s_cnt_local <= s_cnt_local + 1;
            end if;
        end if;  
             
    end if;
    end process p_read;

end Behavioral;
