-- Behavioral of test bench:

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb is
end tb;

architecture behav of tb is

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

signal clk : std_logic;
signal rst : std_logic;
signal sw1_in : std_logic;
signal output_out : std_logic_vector (3 downto 0);
signal wr_out : std_logic;
signal tvalid_out : std_logic;
signal m_axis_tvalid_out : std_logic;
signal m_axis_tdata_out : std_logic_vector (3 downto 0);
signal s_axis_tready_out : std_logic;
signal leds_data_out : std_logic_vector (7 downto 0);

constant T : time := 250 ps; --clk acelarete for tb

begin

-- Input interface instantiation

input_interface_0 : input_interface port map (clk => clk, rst => rst, sw1 => sw1_in, output => output_out, wr => wr_out, tvalid => tvalid_out);

-- Master instantiation

master_0 : master port map (clk => clk, rst => rst, input => output_out, wr => wr_out, tvalid => tvalid_out, m_axis_tready => s_axis_tready_out, m_axis_tvalid => m_axis_tvalid_out, m_axis_tdata => m_axis_tdata_out);

-- Salve instantiation

slave_0 : slave port map (clk => clk, rst => rst, leds_data => leds_data_out, s_axis_tvalid => m_axis_tvalid_out, s_axis_tdata => m_axis_tdata_out, s_axis_tready => s_axis_tready_out);

clock_generation : process
    begin
        clk <= '0';
        wait for T/2;
        clk <= '1';
        wait for T/2;
    end process clock_generation;

test :  process

        -- For the firts data the input is '5' value.  

        -- For the second data the input is '7' value.

        -- Then it's assert the output leds_data is 01110101.  
        
        -- Then it reset, input two new values ​​'1' and '4' and assert it.   

        begin

        rst <= '1';

        wait for 500 ps;

        rst <= '0';
        sw1_in <= '0';

        report "Simulation start. ";
        
        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';
        
        report "First value it's input";

        wait for 21 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        report "Second value it's input";

        wait for 17 ns;

        report "Axistream communication.";

        wait for 2 ns;

        report "led0 :" & std_logic'image(leds_data_out(0));
        
        report "led1 :" & std_logic'image(leds_data_out(1));

        report "led2 :" & std_logic'image(leds_data_out(2));

        report "led3 :" & std_logic'image(leds_data_out(3));
            
        report "led4 :" & std_logic'image(leds_data_out(4));
        
        report "led5 :" & std_logic'image(leds_data_out(5));

        report "led6 :" & std_logic'image(leds_data_out(6));

        report "led7 :" & std_logic'image(leds_data_out(7));

        assert (leds_data_out = "01110101") --expected output
        report "test failed" severity error;
        
        wait for 2 ns;
                    
        rst <= '1';

        wait for 500 ps;

        rst <= '0';
        sw1_in <= '0';

        report "Restart. ";
        
        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';
        
        report "First value it's input";

        wait for 29 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        wait for 1 ns;

        sw1_in <= '1';

        wait for 1 ns;

        sw1_in <= '0';

        report "Second value it's input";

        wait for 23 ns;

        report "Axistream communication.";

        wait for 2 ns;

        report "led0 :" & std_logic'image(leds_data_out(0));
        
        report "led1 :" & std_logic'image(leds_data_out(1));

        report "led2 :" & std_logic'image(leds_data_out(2));

        report "led3 :" & std_logic'image(leds_data_out(3));
            
        report "led4 :" & std_logic'image(leds_data_out(4));
        
        report "led5 :" & std_logic'image(leds_data_out(5));

        report "led6 :" & std_logic'image(leds_data_out(6));

        report "led7 :" & std_logic'image(leds_data_out(7));

        assert (leds_data_out = "01000001") --expected output
        report "test failed" severity error;

        report "Simulation end. ";

        wait;

        end process test;        

end behav;


