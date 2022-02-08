-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Alberto Boffi - Politecnico di Milano, AY 2020/21
-- TEST MODULE: Address producer
--
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addr_prod_tb is end;

architecture arch of addr_prod_tb is
  component addr_prod is
    port(sel_count,load_count,load_wr,i_clk,i_rst: in std_logic; sel_addr: in std_logic_vector(1 downto 0); o_address: out std_logic_vector(15 downto 0));
  end component;

  signal sel_count,load_count,load_wr,i_rst: std_logic;
  signal i_clk: std_logic := '1';
  signal sel_addr: std_logic_vector(1 downto 0);
  signal o_address: std_logic_vector(15 downto 0);

begin
  ADDR_PROD0: addr_prod
  port map (sel_count, load_count, load_wr, i_clk, i_rst, sel_addr, o_address);

  i_clk <= not i_clk after 50 ns;

process
begin
  sel_addr <= "00";
  -- expecting o_address = 0
  wait for 100.1 ns;
  sel_addr <= "01";
  sel_count <= '0';
  load_count <= '1';
  i_rst <= '0';
  -- expecting o_address = 1
  wait for 100.1 ns;
  sel_addr <= "10";
  sel_count <= '1';
  load_wr <= '1';
  -- expecting o_address = 2
  wait for 100.1 ns;
  -- expecting o_address = 3
  wait for 100.1 ns;
  -- expecting o_address = 4
  -- end signal goes high
  wait for 100.1 ns;
  -- fifth state of FSM
  sel_count <= '0';
  load_wr <= '0';
  -- o_address = 5 not relevant
  wait for 100.1 ns; -- 600 ns
  sel_count <= '1';
  -- sel_addr <= "10";
  load_count <= '0';
  -- expecting o_address = 2
  wait for 100.1 ns;
  sel_addr <= "11";
  load_count <= '1';
  -- expecting o_address = 5
  wait for 100.1 ns;
  -- sel_count <= '1';
  sel_addr <= "10";
  load_count <= '0';
  -- expecting o_address = 3
  wait for 100.1 ns;
  sel_addr <= "11";
  load_count <= '1';
  -- expecting o_address = 6
  wait for 100.1 ns;
  -- sel_count <= '1';
  sel_addr <= "10";
  load_count <= '0';
  -- expecting o_address = 4
  wait for 100.1 ns;
  sel_addr <= "11";
  load_count <= '1';
  -- expecting o_address = 7
  wait for 100.1 ns;

  -- Total time: 1.2 micros

end process;
end architecture;
