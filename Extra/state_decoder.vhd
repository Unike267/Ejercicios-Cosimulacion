library IEEE;
use IEEE.std_logic_1164.all;

entity state_decoder is
-- state input is a actual state
-- flag input are two flags of the architecture
-- nstate output is next state
-- en output are the enables of the MPPT architecture
-- rst_ci is a reset for the iteration counter
    port (
            state : in std_logic_vector (2 downto 0);
            flag : in std_logic_vector (1 downto 0);
            nstate : out std_logic_vector (2 downto 0);
            en : out std_logic_vector (3 downto 0);
            rst_ci : out std_logic);
end state_decoder;

architecture rtl of state_decoder is
begin

--Define a true table in this process
state_decoder_flow : process (state,flag)
begin

nstate(2) <= (not(state(2)) and state(1) and state(0)) or (state(2) and not(state(1)) and not(state(0))) or (state(2) and not(state(1)) and not(flag(1)));
nstate(1) <= (not(state(2)) and not(state(1)) and state(0)) or (not(state(2)) and state(1) and not(state (0)));
nstate(0) <= (not(state(1)) and not(state(0)) and flag(0)) or (not(state(2)) and state(1) and not(state(0))) or (state(2) and not(state(1)));
en(3) <= state(2) and not(state(1)) and not(state(0));
en(2) <= not(state(2)) and state(1) and state(0);
en(1) <= not(state(2)) and state(1) and not(state(0));
en(0) <= not(state(2)) and not(state(1)) and state(0);
rst_ci <= (not(state(2)) and not(state(1)) and not(state(0)) and flag(0)) or (state(2) and not(state(1)) and state(0) and flag(1));

end process state_decoder_flow;

end rtl;
