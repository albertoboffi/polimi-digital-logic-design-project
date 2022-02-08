-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Alberto Boffi - Politecnico di Milano, AY 2020/21
-- TEST MODULE: Register
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_tb is end;

architecture arch of reg_tb is

  component reg_pp is
    generic (WIDTH: integer);
    port(d: in unsigned((WIDTH-1) downto 0); clk,load,res: in std_logic; o: out unsigned((WIDTH-1) downto 0));
  end component;

  signal d,o: unsigned(7 downto 0);
  signal res,load: std_logic;
  signal clk: std_logic := '1';

begin
  REG_PP0: reg_pp
    generic map (WIDTH => 8)
    port map (d => d, clk => clk, load => load, res => res, o => o);

  clk <= not clk after 50 ns;
process
begin
  res <= '0';
  load <= '1';
  d <= "00000000";
  wait for 100 ns;
  d <= "00000001";
  wait for 200 ns;
  d <= "11000000";
  wait for 100 ns;
  d <= "00000000";
  wait for 100 ns;
end process;
end architecture;
