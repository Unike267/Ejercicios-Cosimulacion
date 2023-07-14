-- Behavioral of test bench:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture behav of tb is

-- Declaration of scaler component:

component scaler is
port (
        -- From FPGA input
        clk : in std_logic;
        -- To design
        clk_o : out std_logic;
        clk_scan : out std_logic;
        -- To screen
        clk_s : out std_logic
);
end component;

for scaler_0: scaler use entity work.scaler;

-- Declaration of screen component:

component screen is
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
end component;

for screen_0: screen use entity work.screen;

-- Declaration of keyboard component:

component keyboard is
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
end component; 

for keyboard_0: keyboard use entity work.keyboard;

signal clk : std_logic;
signal rst : std_logic;
signal clk_o : std_logic;
signal clk_scan : std_logic;
signal clk_s : std_logic;
signal key : std_logic_vector (4 downto 0);
signal flag_s : std_logic;
signal rst_s : std_logic;
signal ce_s : std_logic;
signal dc_s : std_logic;
signal din_s : std_logic;
signal in_0, in_1, in_2, in_3 : std_logic;
signal out_0, out_1, out_2, out_3 : std_logic;

constant T : time := 83333 ps; --FPGA clk (12 MHZ)

begin

-- scaler instantiation

scaler_0 : scaler port map (clk => clk, clk_o => clk_o, clk_scan => clk_scan, clk_s => clk_s);

-- screen instantation

screen_0 : screen port map (clk_o => clk_o, rst => rst, key => key, flag_s => flag_s, rst_s => rst_s, ce_s => ce_s, dc_s => dc_s, din_s => din_s);

-- keyboard instantation 

keyboard_0 : keyboard port map (clk_o => clk_o, clk_scan => clk_scan, rst => rst, in_0 => in_0, in_1 => in_1, in_2 => in_2, in_3 => in_3, out_0 => out_0, out_1 => out_1, out_2 => out_2, out_3 => out_3, key => key, flag_s => flag_s);


clock_generation : process
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;
    end process clock_generation;

test : process
    begin
       
    rst <= '1';

    wait for 333332 ps;

    rst <= '0';
    in_0 <= '0';
    in_1 <= '0';
    in_2 <= '0';
    in_3 <= '0';

    report "Start simulation. ";
    
    wait for 3 us;

    in_0 <= '1';

    wait for 2 ms;

    in_0 <= '0';

    wait for 6 us;

    in_3 <= '1';

    wait for  2 ms;

    in_3 <= '0';

    wait for 6 us;

    report "Restart. ";
    
    rst <= '1';

    wait for 333332 ps;

    rst <= '0';
    
    wait for 3 us;

    in_2 <= '1';

    wait for 2 ms;

    in_2 <= '0';

    wait for 6 us;

    in_1 <= '1';

    wait for 2 ms;

    in_1 <= '0';

    report "Finish simulation. ";

    wait;
        
    end process test;

end behav;
