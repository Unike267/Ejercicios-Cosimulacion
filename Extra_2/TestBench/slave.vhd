-- RTL of Axi stream slave:


-- When time for inputs it's passed master fifo is full and it start the axi stream communication.

-- When two package of data are send the axi stream communication it finished.

-- The two 4 bits slave register are loaded with axi stream communication datas and display its result on 8 leds.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity slave is
port (
        clk : in std_logic;
        -- External signals
        rst : in std_logic;
        leds_data : out std_logic_vector(7 downto 0);
        -- Axi stream interface
        s_axis_tvalid : in std_logic;
        s_axis_tdata : in std_logic_vector (3 downto 0);
        s_axis_tready : out std_logic
);
end slave;

architecture rtl of slave is

-- Declaration of signals

signal Q1 : std_logic_vector (3 downto 0) := (others => '0');
signal Q0 : std_logic_vector (3 downto 0) := (others => '0');
signal SEL : std_logic_vector (1 downto 0) := (others => '0');
signal tready : std_logic := '0';
signal aux_tready : std_logic := '0';

begin

-- SEL process:

    process ( clk )
        variable cnt : unsigned (1 downto 0) := (others => '0');
    begin
        if( rising_edge( clk ) ) then
            if( rst = '1' ) then
                cnt := "00";
                SEL <= "00";
                aux_tready <= '0';
            elsif( s_axis_tvalid = '1' ) then
                if( cnt = "00" ) then
                    SEL <= "01";
                    cnt := cnt + 1;
                elsif( cnt = "01" ) then
                    SEL <= "10";
                    cnt := cnt + 1;
                elsif( cnt = "10" ) then
                    SEL <= "00";
                    aux_tready <= '1';
                end if;
            end if;
        end if;
                    
    end process;

-- Process of slave register:

    process ( clk ) 
    begin
        if( rising_edge( clk ) ) then
            if( rst = '1' ) then
                Q1 <= "0000";
            elsif( SEL(1) = '1' ) then
                Q1 <= s_axis_tdata;
            else
                Q1 <= Q1;
            end if;
        end if;

        if( rising_edge( clk ) ) then
            if( rst = '1' ) then
                Q0 <= "0000";
            elsif( SEL(0) = '1' ) then
                Q0 <= s_axis_tdata;
            else
                Q0 <= Q0;
            end if;
        end if;
        
    end process;

-- Process of tready

    process ( clk )
    begin
        if( rising_edge( clk ) ) then
            if( rst = '1' ) then
                tready <= '0';
            elsif( s_axis_tvalid = '1' and aux_tready = '0' ) then
                tready <= '1';
            elsif( s_axis_tvalid = '1' and aux_tready = '1' ) then
                tready <= '0';
            end if;
        end if;
    
    end process;

s_axis_tready <= tready;

leds_data(7 downto 4) <= Q1;
leds_data(3 downto 0) <= Q0;

end rtl;
