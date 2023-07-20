-- RTL for 4x4 keyboard

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity keyboard is
port (
        -- From scaler
        clk_o : in std_logic;
        clk_scan : in std_logic;
        -- Form FPGA inputs
        rst : in std_logic;
        in_0, in_1, in_2, in_3 : in std_logic;       
        -- To FPGA outputs     
        out_0, out_1, out_2, out_3 : out std_logic;
        -- To screen component
        key : out std_logic_vector (4 downto 0);
        flag_s : out std_logic
        );
end keyboard; 

architecture rtl of keyboard is

-- Declaration of signals

signal EN : std_logic_vector (1 downto 0) := (others => '0');
signal flag : std_logic := '0';
signal flag_r : std_logic := '0';
signal fil : std_logic_vector (3 downto 0) := (others => '0');
signal col : std_logic_vector (3 downto 0) := (others => '0');
signal Q : std_logic_vector (7 downto 0) := (others => '0');

begin

-- Process of counter for scan keyboard

    process ( clk_scan )
        variable cnt : unsigned (1 downto 0) := (others => '0');
    begin
        if ( rising_edge( clk_scan ) ) then
            if ( rst = '1' ) then
                cnt := "00";
                fil(0) <= '0';
                fil(1) <= '0';
                fil(2) <= '0';
                fil(3) <= '0';
            elsif ( EN(0) = '1' ) then
                cnt := cnt + 1;
                fil(0) <= cnt(1) nor cnt(0);
                fil(1) <= ( cnt(1) xor cnt(0) ) and cnt(0);
                fil(2) <= ( cnt(1) xor cnt(0) ) and cnt(1);
                fil(3) <= cnt(1) and cnt(0);
            end if;
        end if;
    end process;

    out_0 <= fil(0);
    out_1 <= fil(1);
    out_2 <= fil(2);
    out_3 <= fil(3);

-- Assign inputs

    col(0) <= in_0 and not(in_1) and not(in_2) and not(in_3);
    col(1) <= not(in_0) and in_1 and not(in_2) and not(in_3);
    col(2) <= not(in_0) and not(in_1) and in_2 and not(in_3);
    col(3) <= not(in_0) and not(in_1) and not(in_2) and in_3;
    flag <= col(0) or col(1) or col(2) or col(3);

-- Proces of flag

    process ( clk_o )
    begin
        if ( rising_edge( clk_o ) ) then
            if ( rst = '1' ) then
                flag_r <= '0';
            else
                flag_r <= flag;
            end if;
        end if;
    end process;

    flag_s <= flag_r;
        

-- Process of data input register

    process ( clk_o )
    begin
        if ( rising_edge( clk_o ) ) then
            if ( rst = '1' ) then
                Q <= "00000000";
            elsif ( EN(1) = '1' ) then
                Q(0) <= fil(0);
                Q(1) <= fil(1);
                Q(2) <= fil(2);
                Q(3) <= fil(3);
                Q(4) <= col(0);
                Q(5) <= col(1);
                Q(6) <= col(2);
                Q(7) <= col(3);
            else                
                Q <= Q;
            end if;
        end if;
    end process;
                
-- Process of enables

    process ( clk_o )  
        variable aux : std_logic := '0'; 
    begin
        if ( rising_edge( clk_o ) ) then
            if ( rst = '1' ) then
                aux := '0';
                EN <= "00";
            elsif ( flag_r = '0' and aux = '0' ) then
                EN(0) <= '1';
                EN(1) <= '0';
            elsif ( flag_r = '1' and aux = '0' ) then
                EN(0) <= '0';                
                EN(1) <= '1';   
                aux := '1';
            elsif ( flag_r = '1' and aux = '1' ) then
                EN <= "00";
            elsif ( flag_r = '0' and aux = '1' ) then
                aux := '0'; 
            end if;
        end if;
    end process;

-- Assign keys for send to screen, convert register data to number (0 to 16).

key(0) <= (not(Q(7)) and not(Q(6)) and not(Q(5)) and Q(4) and not(Q(3)) and not(Q(2)) and not(Q(1)) and Q(0)) or (not(Q(7)) and not(Q(6)) and not(Q(5)) and Q(4) and not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and not(Q(5)) and Q(4) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and not(Q(5)) and Q(4) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and not(Q(3)) and not(Q(2)) and not(Q(1)) and Q(0)) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0)));

key(1) <= (not(Q(7)) and not(Q(6)) and Q(5) and not(Q(4)) and not(Q(3)) and not(Q(2)) and not(Q(1)) and Q(0)) or (not(Q(7)) and not(Q(6)) and Q(5) and not(Q(4)) and not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and Q(5) and not(Q(4)) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and Q(5) and not(Q(4)) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and not(Q(3)) and not(Q(2)) and not(Q(1)) and Q(0)) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0)));

key(2) <= (not(Q(7)) and not(Q(6)) and not(Q(5)) and Q(4) and not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and not(Q(5)) and Q(4) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and Q(5) and not(Q(4)) and not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and Q(5) and not(Q(4)) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0))) or (Q(7) and not(Q(6)) and not(Q(5)) and not(Q(4)) and not(Q(3)) and not(Q(2)) and not(Q(1)) and Q(0)) or (Q(7) and not(Q(6)) and not(Q(5)) and not(Q(4)) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0)));

key(3) <= (not(Q(7)) and not(Q(6)) and not(Q(5)) and Q(4) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and not(Q(5)) and Q(4) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and Q(5) and not(Q(4)) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and not(Q(6)) and Q(5) and not(Q(4)) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0))) or (not(Q(7)) and Q(6) and not(Q(5)) and not(Q(4)) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0))) or (Q(7) and not(Q(6)) and not(Q(5)) and not(Q(4)) and not(Q(3)) and not(Q(2)) and Q(1) and not(Q(0))) or (Q(7) and not(Q(6)) and not(Q(5)) and not(Q(4)) and not(Q(3)) and Q(2) and not(Q(1)) and not(Q(0)));

key(4) <= (Q(7) and not(Q(6)) and not(Q(5)) and not(Q(4)) and Q(3) and not(Q(2)) and not(Q(1)) and not(Q(0)));

end rtl;
