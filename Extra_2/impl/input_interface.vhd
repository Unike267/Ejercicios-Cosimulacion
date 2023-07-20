-- RTL of input interface:


-- After reset you have 10 seconds to insert first value and other 10 seconds to insert second value.

-- When fisrt value is complete it is written in master fifo and then it reset the inputs counter.

-- When second value is complete it is written in master fifo and finish input interface.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity input_interface is
port (
        clk : in std_logic;        
        rst : in std_logic;        
        sw1 : in std_logic;
        output : out std_logic_vector (3 downto 0);
        wr : out std_logic;
        tvalid : out std_logic
        );
end input_interface;

architecture rtl of input_interface is

--Declaration of signals

signal pause : std_logic := '0';
signal finish : std_logic := '0';

begin

-- Process of inputs counter. When touch switch counter + 1:

    process( clk )
        variable cnt : unsigned (3 downto 0) := (others => '0');
        variable aux : std_logic := '0';
    begin
        if ( rising_edge( clk ) ) then
            if( rst = '1' or pause = '1' or finish = '1') then
                cnt := "0000";
                
                --Assign null state
                output(0) <= cnt(0);
                output(1) <= cnt(1);
                output(2) <= cnt(2);
                output(3) <= cnt(3);
                
            elsif ( sw1 = '1' and aux = '0' ) then
                cnt := cnt + 1;
                aux := '1';

                --Assign counter value
                output(0) <= cnt(0);
                output(1) <= cnt(1);
                output(2) <= cnt(2);
                output(3) <= cnt(3);

            elsif ( sw1 = '0' and aux = '1' ) then
                aux := '0';
            end if;
        end if;
    end process;

-- Process of wr, tvalid, pause and finish signals:

    process( clk )
        variable cnt1 : unsigned (27 downto 0) := (others => '0');
    begin
        if (rising_edge( clk )) then
            if( rst = '1' or finish = '1' ) then
                cnt1 := "0000000000000000000000000000";
                wr <= '0';
                -- Unlock finish signal for more communication
                if (rst = '1' and finish = '1') then
                    finish <= '0';
                    tvalid <= '0';
                end if;
            else
                cnt1 := cnt1 + 1;
                if( cnt1 = "0111001001110000110111111111" ) then
                    wr <= '1';
                elsif( cnt1 = "0111001001110000111000000000" ) then
                    wr <= '0';
                    pause <= '1';                
                elsif( cnt1 = "1110010011100001101111111111" ) then 
                    wr <= '1';
                elsif( cnt1 = "1110010011100001110000000000" ) then
                    wr <= '0';                
                    tvalid <= '1';
                    finish <= '1';
                else
                    pause <= '0';
                    tvalid <= '0';
                end if; 
            end if;
        end if;
    end process;

end rtl;
