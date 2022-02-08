-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Alberto Boffi - Politecnico di Milano, AY 2020/21
-- TEST MODULE: Algorithm
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity algo_tb is end;

architecture arch of algo_tb is

  component algo is
    port (sel_max,load_max,sel_min,load_min,i_clk,i_rst: in std_logic; i_data: in std_logic_vector(7 downto 0); o_data: out std_logic_vector(7 downto 0));
  end component;

  signal sel_max, load_max, sel_min, load_min, i_rst: std_logic;
  signal i_clk: std_logic := '1';
  signal i_data, o_data: std_logic_vector(7 downto 0);

begin
  ALGO0: algo
    port map (sel_max, load_max, sel_min, load_min, i_clk, i_rst, i_data, o_data);

  i_clk <= not i_clk after 50 ns;

process
begin
  sel_max <= '0';
  load_max <= '1';
  sel_min <= '0';
  load_min <= '1';
  i_rst <= '0';

  wait for 100.1 ns;
  sel_max <= '1';
  sel_min <= '1';
  i_data <= "01111011"; -- regular condition
  -- i_data <= "11111111"; -- boundary condition
  wait for 100.1 ns;
  i_data <= "11110000"; -- regular condition
  -- i_data <= "11111111"; -- boundary condition
  wait for 100.1 ns;
  i_data <= "01011010"; -- regular condition
  -- i_data <= "11111111"; -- boundary condition
  wait for 100.1 ns;
  i_data <= "01001001"; -- regular condition
  -- i_data <= "00000000"; -- boundary condition pt.1
  -- i_data <= "11111111"; -- boundary condition pt.2
  wait for 100.1 ns;
  -- s5
  i_data <= "11111111";
  wait for 100.1 ns; -- 600 ns

  load_max <= '0';
  load_min <= '0';
  i_data <= "01111011"; -- regular condition
  -- i_data <= "11111111"; -- boundary condition
  wait for 200.2 ns;
  i_data <= "11110000"; -- regular condition
  -- i_data <= "11111111"; -- boundary condition
  wait for 200.2 ns;
  i_data <= "01011010"; -- regular condition
  -- i_data <= "11111111"; -- boundary condition
  wait for 200.2 ns;
  i_data <= "01001001"; -- regular condition
  -- i_data <= "00000000"; -- boundary condition pt.1
  -- i_data <= "11111111"; -- boundary condition pt.2
  wait for 200.2 ns;
  i_data <= "11111111";
  wait for 100.1 ns; -- 1.5 micros

end process;

end architecture;
