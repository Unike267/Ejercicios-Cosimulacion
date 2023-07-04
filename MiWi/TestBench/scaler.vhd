-- RTL for scaler clock signals

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity scaler is
port (
        -- From FPGA input
        clk : in std_logic;
        -- To design
        clk_o : out std_logic;
        clk_scan : out std_logic;
        -- To screen
        clk_s : out std_logic
);
end scaler;

architecture rtl of scaler is

signal clk_out : std_logic := '0';
signal clk_scan_out : std_logic := '0';

begin
    
    -- Process for clock signals:

    process ( clk )
        variable cnt : unsigned (3 downto 0) := (others => '0');
    begin
        if( rising_edge( clk ) ) then
            cnt := cnt + 1;
            clk_out <= cnt(1);
            clk_scan_out <= cnt(3);
        end if;
    end process;

    clk_o <= clk_out;
    clk_scan <= clk_scan_out;
    clk_s <= not clk_out;

end rtl;
