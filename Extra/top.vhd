library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top is
  port (
    clk : in std_logic;
    rst : in std_logic;
    led0, led1, led2, led3, led4, led5, led6, led7 : out std_logic
  );
end top;

architecture behav of top is

--Declaration of the state decoder component

component state_decoder is
    port (
        state : in std_logic_vector (2 downto 0);
        flag : in std_logic_vector (1 downto 0);
        nstate : out std_logic_vector (2 downto 0);
        en : out std_logic_vector (3 downto 0);
        rst_ci : out std_logic);
end component;

for state_decoder_0: state_decoder use entity work.state_decoder;

--Declaration of signals

signal state_in : std_logic_vector (2 downto 0);
signal flag_in : std_logic_vector (1 downto 0);
signal nstate_out : std_logic_vector (2 downto 0);
signal en_out : std_logic_vector (3 downto 0);
signal rst_ci_out : std_logic;
signal advance : std_logic;

begin

--Component instantiation 
state_decoder_0 : state_decoder port map (state => state_in, flag => flag_in, nstate => nstate_out, en => en_out, rst_ci => rst_ci_out);

-- Advance signal process

    process(clk)
    variable cnt : unsigned (23 downto 0) := (others=>'0');
    begin
        if rising_edge(clk) then
            cnt := cnt + 1;
            advance <= cnt(23);
        end if;
    end process;

-- 5 bits counter for 5 inputs

    process (advance)
        variable counter : unsigned (4 downto 0);
    begin
        if rising_edge(advance) then
            if (rst = '1') then 
                counter:= "00000";

                -- Assign reset state
                flag_in(0) <= counter(0);
                flag_in(1) <= counter(1);
                state_in(0) <= counter(2);
                state_in(1) <= counter(3);
                state_in(2) <= counter(4);
                 
            else
                counter:= counter + 1;
                
                -- Assign inputs
                flag_in(0) <= counter(0);
                flag_in(1) <= counter(1);
                state_in(0) <= counter(2);
                state_in(1) <= counter(3);
                state_in(2) <= counter(4); 
            end if;
        end if;
  end process;      
            
--Assign outputs to leds

led0 <= nstate_out(0);
led1 <= nstate_out(1);
led2 <= nstate_out(2);
led3 <= en_out(0);
led4 <= en_out(1);
led5 <= en_out(2);
led6 <= en_out(3);
led7 <= rst_ci_out;

end behav;
