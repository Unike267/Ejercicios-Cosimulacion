-- TOP FOR FPGA:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
    port (
        clk : in std_logic;
        rst : in std_logic;
        sw1 : in std_logic;
        led0, led1, led2, led3, led4, led5, led6, led7 : out std_logic
    );
end top;

architecture behav of top is

-- Declaration of input_interface component:

component input_interface is
    port (
        clk : in std_logic;        
        rst : in std_logic;        
        sw1 : in std_logic;
        output : out std_logic_vector (3 downto 0);
        wr : out std_logic;
        tvalid : out std_logic
        );
end component;

for input_interface_0: input_interface use entity work.input_interface;

-- Declaration of master component:

component master is
port (
        clk : in std_logic;
        rst : in std_logic;
        input : in std_logic_vector (3 downto 0);
        wr : in std_logic;
        tvalid : in std_logic;
        m_axis_tready : in std_logic;
        m_axis_tvalid : out std_logic;
        m_axis_tdata : out std_logic_vector (3 downto 0)
);
end component;

for master_0: master use entity work.master;

-- Declaration of slave component:

component slave is
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
end component;

for slave_0:slave use entity work.slave;

-- Declaration of signals:

signal output_out : std_logic_vector (3 downto 0);
signal wr_out : std_logic;
signal tvalid_out : std_logic;
signal m_axis_tvalid_out : std_logic;
signal m_axis_tdata_out : std_logic_vector (3 downto 0);
signal s_axis_tready_out : std_logic;
signal leds_data_out : std_logic_vector (7 downto 0);



begin

-- Input interface instantiation

input_interface_0 : input_interface port map (clk => clk, rst => rst, sw1 => sw1, output => output_out, wr => wr_out, tvalid => tvalid_out);

-- Master instantiation

master_0 : master port map (clk => clk, rst => rst, input => output_out, wr => wr_out, tvalid => tvalid_out, m_axis_tready => s_axis_tready_out, m_axis_tvalid => m_axis_tvalid_out, m_axis_tdata => m_axis_tdata_out);

-- Salve instantiation

slave_0 : slave port map (clk => clk, rst => rst, leds_data => leds_data_out, s_axis_tvalid => m_axis_tvalid_out, s_axis_tdata => m_axis_tdata_out, s_axis_tready => s_axis_tready_out);

--Assign outputs to leds

led0 <= leds_data_out(0);
led1 <= leds_data_out(1);
led2 <= leds_data_out(2);
led3 <= leds_data_out(3);
led4 <= leds_data_out(4);
led5 <= leds_data_out(5);
led6 <= leds_data_out(6);
led7 <= leds_data_out(7);

end behav;


