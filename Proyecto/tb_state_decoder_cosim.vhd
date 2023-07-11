-- Testbench for a state decoder logic
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_state_decoder_cosim is
end tb_state_decoder_cosim;

architecture behav of tb_state_decoder_cosim is

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

--Functions declaration

function in_value_state ( x:integer ) return integer is
begin report "VHPIDIRECT in_value_state" severity failure; end;
attribute foreign of in_value_state : function is "VHPIDIRECT in_value_state";

function in_value_flag ( x:integer ) return integer is
begin report "VHPIDIRECT in_value_flag" severity failure; end;
attribute foreign of in_value_flag : function is "VHPIDIRECT in_value_flag";

function out_value_nstate ( x:integer ) return integer is
begin report "VHPIDIRECT out_value_nstate" severity failure; end;
attribute foreign of out_value_nstate : function is "VHPIDIRECT out_value_nstate";

function out_value_en ( x:integer ) return integer is
begin report "VHPIDIRECT out_value_en" severity failure; end;
attribute foreign of out_value_en : function is "VHPIDIRECT out_value_en";

function out_value_rst_ci ( x:integer ) return integer is
begin report "VHPIDIRECT out_value_rst_ci" severity failure; end;
attribute foreign of out_value_rst_ci : function is "VHPIDIRECT out_value_rst_ci";

begin

--Component instantiation
state_decoder_0 : state_decoder port map (state => state_in, flag => flag_in, nstate => nstate_out, en => en_out, rst_ci => rst_ci_out);

--Test for 32 posible combination


test : process

       --Define variables

       variable in_state : integer := 0;
       variable in_flag : integer := 0;
       variable out_nstate : integer := 0;
       variable out_en : integer := 0;
       variable out_rst_ci : integer := 0;
       variable assert_nstate : std_logic_vector (2 downto 0);
       variable assert_en : std_logic_vector (3 downto 0);
       variable assert_rst_ci : std_logic := '0';

       begin
        for i in 1 to 32 loop

            report "Iteration: " & integer'image(i);

            --Print input values

            report "state: " & integer'image( in_value_state(i) ) severity note;
            report "flag: " & integer'image( in_value_flag(i) ) severity note;

            --Capture input values in integer variables

            in_state := in_value_state(i);
            in_flag := in_value_flag(i);

            --Convert to std_logic_vector

            state_in <= std_logic_vector(to_unsigned(in_state, 3));
            flag_in <= std_logic_vector(to_unsigned(in_flag, 2));
            wait for 1 ns;

            --Capture output values in integer variables

            out_nstate := out_value_nstate(i);
            out_en := out_value_en(i);
            out_rst_ci := out_value_rst_ci(i);

            --Convert to std_logic_vector variables

            assert_nstate := std_logic_vector(to_unsigned(out_nstate, 3));
            assert_en := std_logic_vector(to_unsigned(out_en, 4));
            assert_rst_ci := std_logic(to_unsigned(out_rst_ci,1)(0));

            --Assert values

           assert ((nstate_out = assert_nstate) and (en_out = assert_en) and (rst_ci_out = assert_rst_ci)) --expected output
           report "test failed" severity error;

        end loop;
        wait;

       end process;
end behav;


