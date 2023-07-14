-- RTL for Screen

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity screen is
port (
        -- From scaler
        clk_o : in std_logic;
        -- Form FPGA
        rst : in std_logic;
        -- From keyboard component
        key : in std_logic_vector (4 downto 0);
        flag_s : in std_logic;
        -- To screen
        rst_s : out std_logic;
        ce_s : out std_logic;
        dc_s : out std_logic;
        din_s : out std_logic
);
end screen;

architecture rtl of screen is

-- Declaration of signals
signal reset : std_logic := '0';
signal cen : std_logic := '0';
signal dtco : std_logic := '0';
signal dta : std_logic := '0';

signal send_config : std_logic := '0';
signal send_config_ok : std_logic := '0';
signal send_data_ok : std_logic := '0';
signal read_data : std_logic := '0';

-- Declaration of arrays

type array_config is array (5 downto 0) of std_logic_vector (7 downto 0);
signal config : array_config;
type array_data is array (503 downto 0) of std_logic_vector (7 downto 0);
signal data : array_data := (others => (others => '0'));

begin

-- Set config data

    config <= (("00001100"), ("00100000"), ("00010100"), ("00000100"), ("10111000"), ("00100001"));

-- Process for make reset initial pulse to screen

    process ( clk_o )
        variable cnt : unsigned (3 downto 0) := (others => '0');
    begin
        if ( rising_edge( clk_o ) ) then
            if ( rst = '1' ) then
                cnt := "0000";
                reset <= '0';
            elsif ( cnt(3) = '1' ) then
                reset <= '1';
            else
                cnt := cnt + 1;
            end if;
        end if;
    end process;

    rst_s <= reset;

-- Process for dc_s and ce_s

    process ( clk_o )
        variable cnt : unsigned (3 downto 0) := (others => '0');
    begin
        if ( rising_edge( clk_o ) ) then
            if ( rst = '1' ) then
                cnt := "0000";
                send_config <= '0';
                read_data <= '0';
                cen <= '1';
                dtco <= '0';
            elsif ( cnt = "1001") then
                -- Sync with reset signal                
                send_config <= '1';
                cnt := cnt + 1;
            elsif ( cnt = "1010" ) then
                cen <= '0';
                if ( send_config_ok = '1' ) then
                    send_config <= '0';
                    dtco <= '1'; 
                    if ( send_data_ok = '1' ) then
                        read_data <= '1';
                    else
                        read_data <= '0';
                    end if;
                end if;
            else
                cnt := cnt + 1;
            end if;
        end if;
    end process;

    ce_s <= cen;
    dc_s <= dtco;

-- Process for send config and data

    process ( clk_o )
        variable fil : natural range 0 to 503 := 0;  
        variable col : natural range 0 to 7 := 7;  
    begin
        if ( rising_edge( clk_o ) ) then
            if ( rst = '1' ) then
                send_config_ok <= '0';
                send_data_ok <= '0';
                dta <= '0';
                fil := 0;
                col := 7;
            elsif ( send_config = '1' and send_config_ok = '0' ) then
                dta <= config(fil)(col);
                if ( col /= 0 ) then
                    col := col - 1;
                elsif ( fil = 5 and col = 0 ) then
                    send_config_ok <= '1';
                    fil := 0;
                    col := 7;                                
                else
                    col := 7;
                    fil := fil + 1;
                end if;
            elsif ( send_config_ok = '1' ) then
                dta <= data(fil)(col);
                if ( col /= 0 ) then
                    col := col - 1;
                    send_data_ok <= '0';                                 
                elsif ( fil = 503 and col = 0) then
                    fil := 0;
                    col := 7;
                    send_data_ok <= '1';
                else
                    col := 7;                    
                    fil := fil + 1;
                    send_data_ok <= '0'; 
                end if;
            end if;
        end if;
    end process;

    din_s <= dta;

-- Build data

    process ( clk_o )
        variable pnt : unsigned (5 downto 0) := (others => '0');
        variable cnt : unsigned (2 downto 0) := (others => '0');
        variable aux : std_logic := '0';
    begin
        if ( rising_edge( clk_o ) ) then
            if ( rst = '1' ) then
                pnt := "000000";
                cnt := "000";                
                aux := '0';
                -- Set constant data "MiWi:"
                data(27 downto 0) <= (("00000000"),("00100100"),("00000000"),("00110100"),("00000000"),("00000110"),("00011000"),("00100000"),("00010000"),("00001000"),("00010000"),("00100000"),("00011000"),("00000110"),("00000000"),("00000000"),("00000000"),("00110100"),("00000000"),("00110000"),("00001100"),("00000010"),("00000100"),("00001000"),("00000100"),("00000010"),("00001100"),("00110000"));
                -- Reset variable data
                data(503 downto 28) <= (others => (others => '0'));
            elsif ( flag_s = '1' and aux = '0' and read_data = '1' ) then
                if ( cnt = "111" )  then
                    -- Reset pointer and variable data if it's write one line, 7 datas (8 x 6 pixel per data)  ...                
                    pnt := "000000";
                    cnt := "000";
                    data(503 downto 28) <= (others => (others => '0'));
                else
                   
                    aux := '1';
                    cnt := cnt + 1;

                    data(29 + to_integer(unsigned(pnt))) <= "00000000";

                    with key select
                    data(30 + to_integer(unsigned(pnt))) <= "00111110" when "00001",
                                                            "00111110" when "00010",
                                                            "00111110" when "00011",
                                                            "00111110" when "00100",
                                                            "00000000" when "00101",
                                                            "00101110" when "00110",
                                                            "00111110" when "00111",
                                                            "00111110" when "01000",
                                                            "00111110" when "01001",
                                                            "00111110" when "01010",
                                                            "00000000" when "01011",
                                                            "00111110" when "01100",
                                                            "00111110" when "01101",
                                                            "00001110" when "01110",
                                                            "01110000" when "01111",
                                                            "00000000" when others;
                    
                    with key select
                    data(31 + to_integer(unsigned(pnt))) <= "00001010" when "00001",
                                                            "00001010" when "00010",
                                                            "00100010" when "00011",
                                                            "00001010" when "00100",
                                                            "00100010" when "00101",
                                                            "00101010" when "00110",
                                                            "00100010" when "00111",
                                                            "00100010" when "01000",
                                                            "00100000" when "01001",
                                                            "00000100" when "01010",
                                                            "00000010" when "01011",
                                                            "00101010" when "01100",
                                                            "00001010" when "01101",
                                                            "00010000" when "01110",
                                                            "01000110" when "01111",
                                                            "00000000" when others;
                    
                    with key select
                    data(32 + to_integer(unsigned(pnt))) <= "00001010" when "00001",
                                                            "00001010" when "00010",
                                                            "00101010" when "00011",
                                                            "00001010" when "00100",
                                                            "00111110" when "00101",
                                                            "00101010" when "00110",
                                                            "00100010" when "00111",
                                                            "00100010" when "01000",
                                                            "00100000" when "01001",
                                                            "00001000" when "01010",
                                                            "00111110" when "01011",
                                                            "00101010" when "01100",
                                                            "00011010" when "01101",
                                                            "00100000" when "01110",
                                                            "01000000" when "01111",
                                                            "00000000" when others;
                        
                    with key select
                    data(33 + to_integer(unsigned(pnt))) <= "00000010" when "00001",
                                                            "00001110" when "00010",
                                                            "00111010" when "00011",
                                                            "00111110" when "00100",
                                                            "00100010" when "00101",
                                                            "00111010" when "00110",
                                                            "00100010" when "00111",
                                                            "00111110" when "01000",
                                                            "00100000" when "01001",
                                                            "00000100" when "01010",
                                                            "00000010" when "01011",
                                                            "00100010" when "01100",
                                                            "00101110" when "01101",
                                                            "00010000" when "01110",
                                                            "01000110" when "01111",
                                                            "00000000" when others;
                                    
                    with key select
                    data(34 + to_integer(unsigned(pnt))) <= "00111110" when "01010",
                                                            "00001110" when "01110",
                                                            "01110000" when "01111",
                                                            "00000000" when others;
                    
                    pnt := pnt + 7;

                end if;

            elsif ( flag_s = '0' and aux = '1' ) then
                aux := '0';
            else
                -- Set cursor
                    if ( cnt /= "111" ) then
                            data(28 + to_integer(unsigned(pnt))) <= "11111111";
                            -- Clear previous cursor
                            if ( pnt /= "000000" ) then                              
                                data(28 + to_integer(unsigned(pnt)) - 7) <= "00000000";
                            end if;
                    end if;
            end if;
        end if;
    end process;
    
end rtl;
