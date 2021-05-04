library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity dls is
    Port(
        clk     : in std_logic;
        arst    : in std_logic;
        digit_i : in std_logic_vector(4 - 1 downto 0);  -- Input value from keypad
        cnp_i   : in std_logic_vector(3 - 1 downto 0);  -- Position of the input value
        relay_o : out std_logic;                        -- Relay output (I/O) 
        data0_o : out std_logic_vector(4 - 1 downto 0); -- Output of first value moved to first display
        data1_o : out std_logic_vector(4 - 1 downto 0); -- Output of second value moved to second display
        data2_o : out std_logic_vector(4 - 1 downto 0); -- Output of third value moved to third display
        data3_o : out std_logic_vector(4 - 1 downto 0); -- Output of fourth value moved to fourth display
        led_o   : out std_logic_vector(3 - 1 downto 0)  -- Output of LED diode (100-red, 010-green)
    );
end dls;

architecture Behavioral of dls is

    -- Possible states
    type t_state is (s0, s1, s2, s3, s4, s5);
    
    -- Signals that use different states
    signal s_present_state : t_state;
    signal s_next_state    : t_state;

    -- Internal clock enable
    signal s_en            : std_logic;
    signal fail            : std_logic;
    -- Local delay counter
    signal s_cnt           : unsigned(5 - 1 downto 0);
    
    
    
    -- Specific values for local counter
    constant c_delay : unsigned(5 - 1 downto 0)      := b"0_0100";      --Delay betweeen states and for opening door
    constant c_zero       : unsigned(5 - 1 downto 0) := b"0_0000"; --Constant for making the count of delay zero
   

begin

    s_en <= '1';
    
    p_code_check : process(clk)
    begin
     if rising_edge(clk) then
        if (arst = '1') then              -- Asynchronous reset
            s_next_state <= s0;        -- Set initial state
        end if;
        
            s_present_state <= s_next_state;
            
        case s_present_state is     -- Case for present states, values are reseted to zero,
            when s0 =>              -- case is counting from state s0 to state s5 (if the inputs are correct).
            fail <= '0';            -- If the input/s is/are wrong the fail is set to 1 and the process is 
            data0_o <= "0000";      -- in the case s4 reseted. 
            data1_o <= "0000";      -- The values from each state are writen in data0_o, data1_o, data2_o and data4_o.
            data2_o <= "0000";      -- If the # button is pressed process resets prematurely. 
            data3_o <= "0000";      -- If the inputs are all correct the relay opens and the LED changes its,
            relay_o <= '0';         -- color from red to green for a several moments
            led_o <= "100";
                if  (cnp_i = "000")then
                
                    if  digit_i = "1100" then
                        s_next_state <= s0;
                    end if;    
                    if  digit_i /= "0001" then
                        fail <= '1';
                    end if;
                    data0_o <= digit_i;
                    s_next_state <= s1;
                end if;
            
            
            when s1 =>
                if  (cnp_i = "001")then
                    if (s_cnt < c_delay) then
                      s_cnt <= s_cnt + 1;
                    else
                      s_cnt <= c_zero;
                      s_next_state <= s0;
                    end if;
                    
                    if  digit_i = "1100" then
                        s_next_state <= s0;
                    end if;   
                  
                    if  digit_i /= "0010" then
                      fail <= '1';
                    end if;
                    data1_o <= digit_i;
                    s_next_state <= s2;  
                end if;
            
            
            
            when s2 =>
                if  (cnp_i = "010")then
                     s_cnt <= c_zero;
                     if (s_cnt < c_delay) then
                         s_cnt <= s_cnt + 1;
                     else
                         s_next_state <= s0;
                     end if;
                     
                     if  digit_i = "1100" then
                        s_next_state <= s0;
                     end if;   
                     
                     if  digit_i /= "0011" then
                         fail <= '1';
                     end if;
                     data2_o <= digit_i;
                     s_next_state <= s3;
                end if;
            
            
            
            when s3 =>
                if  (cnp_i = "011")then
                   s_cnt <= c_zero;
                   if (s_cnt < c_delay) then
                       s_cnt <= s_cnt + 1;
                   else
                       s_next_state <= s0;
                   end if;
                   
                   if  digit_i = "1100" then
                        s_next_state <= s0;
                   end if;   
                   
                   if  digit_i /= "0100" then
                       fail <= '1';
                   end if;
                   data3_o <= digit_i;
                   s_next_state <= s4;
                end if;
            
            
            
            when s4 =>
                if  (cnp_i = "100")then
                    if (s_cnt < c_delay) then     
                        s_cnt <= s_cnt + 1;            
                    else                               
                        s_next_state <= s0;            
                    end if; 
                    
                    if  digit_i = "1100" then
                        s_next_state <= s0;
                    end if;                              

                    if (digit_i = "1010" and fail = '0') then -- Confirming the code with *
                       s_next_state <= s5;
                    else
                    s_next_state <= s0; 
                    end if;
                    
                end if;
                
            when s5 =>
                    relay_o <= '1';
                    led_o <= "010";
                    s_cnt <= c_zero;
                 if (s_cnt < c_delay) then
                           s_cnt <= s_cnt + 1;
                 else
                     relay_o <= '0';
                     led_o <= "100";
                     s_cnt <= c_zero;
                     s_next_state <= s0;
                 end if;   
             
             when others =>
               s_next_state <= s0;
               
        end case;
    end if;
    end process p_code_check;
                             
end architecture Behavioral;
