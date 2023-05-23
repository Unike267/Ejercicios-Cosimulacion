-- Testbench for a state decoder logic
library ieee;
use ieee.std_logic_1164.all;

entity tb_state_decoder is
end tb_state_decoder;

architecture behav of tb_state_decoder is

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

signal state_in : std_logic_vector (2 downto 0);
signal flag_in : std_logic_vector (1 downto 0);
signal nstate_out : std_logic_vector (2 downto 0);
signal en_out : std_logic_vector (3 downto 0);
signal rst_ci_out : std_logic;

begin

--Component instantiation 
state_decoder_0 : state_decoder port map (state => state_in, flag => flag_in, nstate => nstate_out, en => en_out, rst_ci => rst_ci_out);

--Test for 32 posible combination

test : process
       begin
        --Iteration 1        
        state_in <= "000";
        flag_in <= "00";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 000 and flag 00" severity error;
        --Iteration 2        
        state_in <= "000";
        flag_in <= "01";
        wait for 1 ns;
        assert ((nstate_out = "001") and (en_out = "0000") and (rst_ci_out = '1')) --expected output
        report "test failed for state 000 and flag 01" severity error;
        --Iteration 3        
        state_in <= "000";
        flag_in <= "10";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 000 and flag 10" severity error;
        --Iteration 4       
        state_in <= "000";
        flag_in <= "11";
        wait for 1 ns;
        assert ((nstate_out = "001") and (en_out = "0000") and (rst_ci_out = '1')) --expected output
        report "test failed for state 000 and flag 11" severity error;
        --Iteration 5        
        state_in <= "001";
        flag_in <= "00";
        wait for 1 ns;
        assert ((nstate_out = "010") and (en_out = "0001") and (rst_ci_out = '0')) --expected output
        report "test failed for state 001 and flag 00" severity error;
        --Iteration 6        
        state_in <= "001";
        flag_in <= "01";
        wait for 1 ns;
        assert ((nstate_out = "010") and (en_out = "0001") and (rst_ci_out = '0')) --expected output
        report "test failed for state 001 and flag 01" severity error;
        --Iteration 7       
        state_in <= "001";
        flag_in <= "10";
        wait for 1 ns;
        assert ((nstate_out = "010") and (en_out = "0001") and (rst_ci_out = '0')) --expected output
        report "test failed for state 001 and flag 10" severity error;
        --Iteration 8        
        state_in <= "001";
        flag_in <= "11";
        wait for 1 ns;
        assert ((nstate_out = "010") and (en_out = "0001") and (rst_ci_out = '0')) --expected output
        report "test failed for state 001 and flag 11" severity error;
        --Iteration 9        
        state_in <= "010";
        flag_in <= "00";
        wait for 1 ns;
        assert ((nstate_out = "011") and (en_out = "0010") and (rst_ci_out = '0')) --expected output
        report "test failed for state 010 and flag 00" severity error;
        --Iteration 10       
        state_in <= "010";
        flag_in <= "01";
        wait for 1 ns;
        assert ((nstate_out = "011") and (en_out = "0010") and (rst_ci_out = '0')) --expected output
        report "test failed for state 010 and flag 01" severity error;
        --Iteration 11        
        state_in <= "010";
        flag_in <= "10";
        wait for 1 ns;
        assert ((nstate_out = "011") and (en_out = "0010") and (rst_ci_out = '0')) --expected output
        report "test failed for state 010 and flag 10" severity error;
        --Iteration 12        
        state_in <= "010";
        flag_in <= "11";
        wait for 1 ns;
        assert ((nstate_out = "011") and (en_out = "0010") and (rst_ci_out = '0')) --expected output
        report "test failed for state 010 and flag 11" severity error;
        --Iteration 13        
        state_in <= "011";
        flag_in <= "00";
        wait for 1 ns;
        assert ((nstate_out = "100") and (en_out = "0100") and (rst_ci_out = '0')) --expected output
        report "test failed for state 011 and flag 00" severity error;
        --Iteration 14        
        state_in <= "011";
        flag_in <= "01";
        wait for 1 ns;
        assert ((nstate_out = "100") and (en_out = "0100") and (rst_ci_out = '0')) --expected output
        report "test failed for state 011 and flag 01" severity error;
        --Iteration 15       
        state_in <= "011";
        flag_in <= "10";
        wait for 1 ns;
        assert ((nstate_out = "100") and (en_out = "0100") and (rst_ci_out = '0')) --expected output
        report "test failed for state 011 and flag 10" severity error;
        --Iteration 16        
        state_in <= "011";
        flag_in <= "11";
        wait for 1 ns;
        assert ((nstate_out = "100") and (en_out = "0100") and (rst_ci_out = '0')) --expected output
        report "test failed for state 011 and flag 11" severity error;
        --Iteration 17        
        state_in <= "100";
        flag_in <= "00";
        wait for 1 ns;
        assert ((nstate_out = "101") and (en_out = "1000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 100 and flag 00" severity error;
        --Iteration 18        
        state_in <= "100";
        flag_in <= "01";
        wait for 1 ns;
        assert ((nstate_out = "101") and (en_out = "1000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 100 and flag 01" severity error;
        --Iteration 19        
        state_in <= "100";
        flag_in <= "10";
        wait for 1 ns;
        assert ((nstate_out = "101") and (en_out = "1000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 100 and flag 10" severity error;
        --Iteration 20        
        state_in <= "100";
        flag_in <= "11";
        wait for 1 ns;
        assert ((nstate_out = "101") and (en_out = "1000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 100 and flag 11" severity error;
        --Iteration 21        
        state_in <= "101";
        flag_in <= "00";
        wait for 1 ns;
        assert ((nstate_out = "101") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 101 and flag 00" severity error;
        --Iteration 22       
        state_in <= "101";
        flag_in <= "01";
        wait for 1 ns;
        assert ((nstate_out = "101") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 101 and flag 01" severity error;
        --Iteration 23        
        state_in <= "101";
        flag_in <= "10";
        wait for 1 ns;
        assert ((nstate_out = "001") and (en_out = "0000") and (rst_ci_out = '1')) --expected output
        report "test failed for state 101 and flag 10" severity error;
        --Iteration 24        
        state_in <= "101";
        flag_in <= "11";
        wait for 1 ns;
        assert ((nstate_out = "001") and (en_out = "0000") and (rst_ci_out = '1')) --expected output
        report "test failed for state 101 and flag 11" severity error;
        --Iteration 25        
        state_in <= "110";
        flag_in <= "00";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 110 and flag 00" severity error;
        --Iteration 26        
        state_in <= "110";
        flag_in <= "01";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 110 and flag 01" severity error;
        --Iteration 27        
        state_in <= "110";
        flag_in <= "10";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 110 and flag 10" severity error;
        --Iteration 28        
        state_in <= "110";
        flag_in <= "11";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 110 and flag 11" severity error;
        --Iteration 29        
        state_in <= "111";
        flag_in <= "00";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 111 and flag 00" severity error;
        --Iteration 30        
        state_in <= "111";
        flag_in <= "01";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 111 and flag 01" severity error;
        --Iteration 31        
        state_in <= "111";
        flag_in <= "10";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 111 and flag 10" severity error;
        --Iteration 32        
        state_in <= "111";
        flag_in <= "11";
        wait for 1 ns;
        assert ((nstate_out = "000") and (en_out = "0000") and (rst_ci_out = '0')) --expected output
        report "test failed for state 111 and flag 11" severity error;
       
       end process;
end behav;

               
