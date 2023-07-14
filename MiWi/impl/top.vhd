-- TOP for FPGA:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    -- From FPGA
    clk : in std_logic;
    rst : in std_logic;
    -- To Screen
    reset, ce, dc, din, clock : out std_logic;
    -- From keyboard
    in_0, in_1, in_2, in_3 : in std_logic;
    -- To keyboard
    out_0, out_1, out_2, out_3 : out std_logic
  );
end top;

architecture behav of top is

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

-- Declaration of signals

signal clk_o : std_logic;
signal clk_scan : std_logic;
signal key : std_logic_vector (4 downto 0);
signal flag_s : std_logic;

begin

-- scaler instantiation

scaler_0 : scaler port map (clk => clk, clk_o => clk_o, clk_scan => clk_scan, clk_s => clock);

-- screen instantation

screen_0 : screen port map (clk_o => clk_o, rst => rst, key => key, flag_s => flag_s, rst_s => reset, ce_s => ce, dc_s => dc, din_s => din);

-- keyboard instantation 

keyboard_0 : keyboard port map (clk_o => clk_o, clk_scan => clk_scan, rst => rst, in_0 => in_0, in_1 => in_1, in_2 => in_2, in_3 => in_3, out_0 => out_0, out_1 => out_1, out_2 => out_2, out_3 => out_3, key => key, flag_s => flag_s);


end behav;
