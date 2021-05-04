-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2021 21:54:18
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
  Port
      (
          CLK100MHZ    : in    STD_LOGIC;
          BTN          : in    STD_LOGIC;
          JA           : inout STD_LOGIC_VECTOR(7 - 1 downto 0);
          JB           : out   STD_LOGIC;
          JC           : out   STD_LOGIC_VECTOR(7 - 1 downto 0);
          JD           : out   STD_LOGIC_VECTOR(4 - 1 downto 0);
          LED0         : out   STD_LOGIC_VECTOR(3 - 1 downto 0)
          
      );
end top;

------------------------------------------------------------------------
-- Architecture body for top level
------------------------------------------------------------------------
architecture Behavioral of top is
    -- No internal signals
begin

    --------------------------------------------------------------------
    -- Instance of dls entity
    door_lock_system : entity work.door_lock_system
        port map(
            clk         => CLK100MHZ,
            reset       => BTN,
            
            btn_col(0)  => ja(0),
            btn_col(1)  => ja(1),
            btn_col(2)  => ja(2),
            
            btn_row(0)  => ja(3),
            btn_row(1)  => ja(4),
            btn_row(2)  => ja(5),
            btn_row(3)  => ja(6),
            
            relay_o     => jb,
            
            led_o(0)    => led0(0),
            led_o(1)    => led0(1),
            led_o(2)    => led0(2),
                      
            seg_o(0)    => jc(0),
            seg_o(1)    => jc(1),
            seg_o(2)    => jc(2),
            seg_o(3)    => jc(3),
            seg_o(4)    => jc(4),
            seg_o(5)    => jc(5),
            seg_o(6)    => jc(6),
           
            dig_o(0)    => jd(0),
            dig_o(1)    => jd(1),
            dig_o(2)    => jd(2),
            dig_o(3)    => jd(3)
        );

end architecture Behavioral;