-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Alberto Boffi - Politecnico di Milano, AY 2020/21
-- TEST MODULE: Multiplexer
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux_tb is end;

architecture arch of mux_tb is
  component mux is
    generic (WIDTH: integer);
    port(d1,d2: in unsigned((WIDTH-1) downto 0); sel: in std_logic; o: out unsigned((WIDTH-1) downto 0));
  end component;

  signal d1, d2, o: unsigned(7 downto 0);
  signal sel: std_logic;

begin
  MUX0: mux
    generic map (WIDTH => 8)
    port map (d1 => d1, d2 => d2, sel => sel, o => o);

process
begin
d1 <= "10010010";
d2 <= "01101101";
sel <= 'Z';
wait for 100 ns;
sel <= '0';
wait for 100 ns;
sel <= '1';
wait for 100 ns;
d2 <= "11111111";
wait for 100 ns;
d1 <= "00000000";
sel <= '0';
wait for 100 ns;
end process;
end architecture;
