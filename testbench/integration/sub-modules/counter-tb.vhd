-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Alberto Boffi - Politecnico di Milano, AY 2020/21
-- TEST MODULE: Counter
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter_tb is end;

architecture arch of counter_tb is
  component counter is
    port (sel_rowc, load_rowc, load_nrows, sel_colc, load_colc, load_ncol, i_clk, i_rst: in std_logic; i_data: in std_logic_vector(7 downto 0); o_end: out std_logic);
  end component;

  signal sel_rowc, load_rowc, load_nrows, sel_colc, load_colc, load_ncol, i_rst, o_end: std_logic;
  signal i_clk: std_logic := '1';
  signal i_data: std_logic_vector(7 downto 0);

begin
  COUNTER0: counter
  port map (sel_rowc, load_rowc, load_nrows, sel_colc, load_colc, load_ncol, i_clk, i_rst, i_data, o_end);

  i_clk <= not i_clk after 50 ns;

process
begin
  i_rst <= '0';

  sel_rowc <= '0';
  load_rowc <= '0';
  load_nrows <= '0';
  sel_colc <= '0';
  load_colc <= '0';
  load_ncol <= '0';

  -- s2
  load_nrows <= '1';
  i_data <= "00000011"; -- regular condition (to test internal signals)
  -- i_data <= "10000000"; -- boundary condition
  -- wait for 100 ns;
  wait for 100.1 ns;

  -- s3
  load_ncol <= '1';
  load_nrows <= '0';
  i_data <= "00000010"; -- regular condition (to test internal signals)
  -- i_data <= "10000000"; -- boundary condition

  load_rowc <= '1';
  load_colc <= '1';
  -- wait for 100 ns;
  wait for 100.1 ns;

  -- s3
  load_ncol <= '0';
  sel_rowc <= '1';
  sel_colc <= '1';

  -- wait for 600 ns; -- regular conditions
  wait for 600.6 ns;
  -- wait for 1.6384 ms; -- boundary conditions
  -- wait for 1.80224 ms;

end process;
end architecture;
