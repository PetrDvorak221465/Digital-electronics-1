----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.04.2021 18:01:34
-- Design Name: 
-- Module Name: doorl_lock_system - Behavioral
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

entity door_lock_system is
    Port (
        clk     : in  std_logic;                           -- Main clock
        reset   : in  std_logic;                           -- Synchronous reset 
        btn_row : in  std_logic_vector(4 - 1 downto 0); -- Input from keypad button rows
        cnt_up_i: in  std_logic;
        seg_o   : out std_logic_vector(7 - 1 downto 0);    -- Cathode values for individual segments
        dig_o   : out std_logic_vector(4 - 1 downto 0);     -- Common anode signals to individual displays
        btn_col : out std_logic_vector(3 - 1 downto 0); -- Output for keypad button columns
        relay_o : out std_logic;                       -- Relay output (I/O) 
        led_o   : out std_logic_vector(3 - 1 downto 0)
        );
        
end door_lock_system;


------------------------------------------------------------------------
-- Architecture declaration for display driver
------------------------------------------------------------------------
architecture Behavioral of door_lock_system is

    signal s_en    : std_logic;                           -- Internal clock enable
    signal s_cnt   : std_logic_vector(2 - 1 downto 0);    -- Internal 2-bit counter for multiplexing 4 digits
    signal s_hex   : std_logic_vector(4 - 1 downto 0);    -- Internal 4-bit value for 7-segment decoder
    signal s_digit : std_logic_vector(4 - 1 downto 0);    -- Internal 4-bit value number for FSM_doorlock
    signal s_cnp   : std_logic_vector(3 - 1 downto 0);    -- Internal 3-bit position of the input value
    signal s_data0 : std_logic_vector(4 - 1 downto 0);    -- Internal 4-bit values for multiplexer
    signal s_data1 : std_logic_vector(4 - 1 downto 0);
    signal s_data2 : std_logic_vector(4 - 1 downto 0);
    signal s_data3 : std_logic_vector(4 - 1 downto 0);

begin
--------------------------------------------------------------------
    -- Instance of clock_enable entity that generates an enable pulse
    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 4
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

    --------------------------------------------------------------------
    -- Instance of cnt_up_down entity performs a 2-bit counter
    bin_cnt0 : entity work.cnt_up_down
        generic map(
            g_CNT_WIDTH => 2
        )
        port map(
            clk      => clk,
            reset    => reset,
            en_i     => s_en,
            cnt_up_i => cnt_up_i,
            cnt_o    => s_cnt
        );

    --------------------------------------------------------------------
    -- Instance of hex_7seg entity performs a 7-segment display decoder
    hex2seg : entity work.hex_7seg
        port map(
            hex_i => s_hex,
            seg_o => seg_o
        );
        
    --------------------------------------------------------------------
    -- Instance of mux entity performs a 4-to-1 multiplexer
    mux_4to1 : entity work.mux
        port map(
            cnt_i   => s_cnt,
            data0_i => s_data0,
            data1_i => s_data1,
            data2_i => s_data2,
            data3_i => s_data3,
            hex_o   => s_hex,
            dig_o   => dig_o
        );
    

    btn_to_num : entity work.btn_to_num
        port map(
            clk     => clk,    
            reset   => reset,  
            btn_row => btn_row,
            btn_col => btn_col,
            hex_o   => s_digit,
            key_p_o => s_cnp
        );
        
    dls : entity work.dls
        port map(
                clk     => clk,    
                arst    => reset,   
                digit_i => s_digit,
                cnp_i   => s_cnp,  
                relay_o => relay_o,
                data0_o => s_data0,
                data1_o => s_data1,  
                data2_o => s_data2,  
                data3_o => s_data3,  
                led_o   => led_o
            
        );   
end Behavioral;
