-- RTL of Axi stream master:


-- When from input interface come wr = '1' data it's written in master fifo.

-- Fifo has 2 elements with 4 bits per element.

-- When the 2 inputs data is written the axi stream communication start and send two packages of 4 bits.

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity master is
port (
        clk : in std_logic;
        -- External signals
        rst : in std_logic;
        input : in std_logic_vector (3 downto 0);
        wr : in std_logic;
        tvalid : in std_logic;
        -- Axi stream interface
        m_axis_tready : in std_logic;
        m_axis_tvalid : out std_logic;
        m_axis_tdata : out std_logic_vector (3 downto 0)
);
end master;

architecture rtl of master is

--Declaration of fifo array and signals.

type array_type is array (1 downto 0) of std_logic_vector (3 downto 0);
signal fifo_array : array_type;
signal rd : std_logic := '0';

begin

-- Internal fifo process:

    process ( clk )
            variable cnt : natural range 0 to 2 := 0;            
    begin
        if ( rising_edge( clk ) ) then
            if ( rst = '1' ) then
                fifo_array <= "0000" & "0000";
                cnt := 0;
            elsif ( wr = '1' and cnt /= 2 ) then
                fifo_array(cnt) <= input;
                cnt := cnt + 1;
            elsif ( rd = '1' and cnt /= 0 ) then
                cnt := cnt - 1;
                -- Clean the read data.
                fifo_array <= "0000" & fifo_array(1);
            end if;
        end if;
    end process;

rd <= tvalid and m_axis_tready;
 
m_axis_tvalid <= tvalid;
m_axis_tdata <= fifo_array(0);
                
        
end rtl;
