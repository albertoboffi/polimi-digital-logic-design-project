-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Politecnico di Milano - AY 2020/21
-- Author: Alberto Boffi (C.P. 10XXXXXX)
--
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- Two-data-input multiplexer
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mux is
  generic (WIDTH: integer);
  port(d1,d2: in unsigned((WIDTH-1) downto 0); sel: in std_logic; o: out unsigned((WIDTH-1) downto 0));
end entity;

architecture arch_mux of mux is
begin
  with sel select
    o <= d1 when '0',
    d2 when '1',
    (others => 'X') when others;
end architecture;

-------------------------------------------------------------------------------
-- PIPO register
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity reg_pp is
  generic (WIDTH: integer);
  port(d: in unsigned((WIDTH-1) downto 0); clk,load,res: in std_logic; o: out unsigned((WIDTH-1) downto 0));
end entity;

architecture arch_reg_pp of reg_pp is
begin
process (clk,res)
begin
  if (res = '1') then
    o <= (others => '0');
  elsif (rising_edge(clk) and load='1') then
    o <= d;
  end if;
end process;
end architecture;

-------------------------------------------------------------------------------
-- Algorithm
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity algo is
  port (sel_max,load_max,sel_min,load_min,i_clk,i_rst: in std_logic; i_data: in std_logic_vector(7 downto 0); o_data: out std_logic_vector(7 downto 0));
end entity;

architecture arch_algo of algo is

  component mux is
    generic (WIDTH: integer);
    port(d1,d2: in unsigned((WIDTH-1) downto 0); sel: in std_logic; o: out unsigned((WIDTH-1) downto 0));
  end component;
  component reg_pp is
    generic (WIDTH: integer);
    port(d: in unsigned((WIDTH-1) downto 0); clk,load,res: in std_logic; o: out unsigned((WIDTH-1) downto 0));
  end component;

  signal d1_MUX_max, o_MUX_max, max_pixel_value, o_COMP_max, d1_MUX_min, o_MUX_min, min_pixel_value, o_COMP_min, curr_pixel_value, pixel_pos: unsigned(7 downto 0);
  signal log_arg: unsigned(8 downto 0);
  signal temp_pixel: unsigned(15 downto 0);

begin
  curr_pixel_value <= unsigned(i_data); -- casts i_data

  -- Computes max_pixel_value
  d1_MUX_max <= "00000000";

  MUX_max: mux
    generic map (WIDTH => 8)
    port map (d1 => d1_MUX_max, d2 => o_COMP_max, sel => sel_max, o => o_MUX_max);

  REG_max: reg_pp
    generic map (WIDTH => 8)
    port map (d => o_MUX_max, clk => i_clk, load => load_max, res => i_rst, o => max_pixel_value);

  o_COMP_max <= max_pixel_value when max_pixel_value > curr_pixel_value else curr_pixel_value;

  -- Computes min_pixel_value
  d1_MUX_min <= "11111111";

  MUX_min: mux
    generic map (WIDTH => 8)
    port map (d1 => d1_MUX_min, d2 => o_COMP_min, sel => sel_min, o => o_MUX_min);

  REG_min: reg_pp
    generic map (WIDTH => 8)
    port map (d => o_MUX_min, clk => i_clk, load => load_min, res => i_rst, o => min_pixel_value);

  o_COMP_min <= min_pixel_value when min_pixel_value < curr_pixel_value else curr_pixel_value;

  -- Computes algorithm instructions
  log_arg <= ('0' & (max_pixel_value - min_pixel_value)) + "000000001"; -- delta_value +1

  temp_pixel <= -- Shift
    "00000000" & pixel_pos when log_arg="100000000" else -- shift_level=0
    "0000000" & pixel_pos & '0' when log_arg(8)='0' and log_arg(7)='1' else -- shift_level=1
    "000000" & pixel_pos & "00" when log_arg(8 downto 7)="00" and log_arg(6)='1' else -- shift_level=2
    "00000" & pixel_pos & "000" when log_arg(8 downto 6)="000" and log_arg(5)='1' else -- shift_level=3
    "0000" & pixel_pos & "0000" when log_arg(8 downto 5)="0000" and log_arg(4)='1' else -- shift_level=4
    "000" & pixel_pos & "00000" when log_arg(8 downto 4)="00000" and log_arg(3)='1' else -- shift_level=5
    "00" & pixel_pos & "000000" when log_arg(8 downto 3)="000000" and log_arg(2)='1' else -- shift_level=6
    "0" & pixel_pos & "0000000" when log_arg(8 downto 2)="0000000" and log_arg(1)='1' else -- shift_level=7
    pixel_pos & "00000000" when log_arg="000000001" else -- shift_level=8
    (others => 'X');

  pixel_pos <= curr_pixel_value - min_pixel_value; -- current_pixel_value - min_pixel_value

  with temp_pixel(15 downto 8) select -- new_pixel_value = min(255, temp_pixel)
    o_data <= std_logic_vector(temp_pixel(7 downto 0)) when "00000000",
    "11111111" when others;
end architecture;

-------------------------------------------------------------------------------
-- Addresses producer
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addr_prod is
  port(sel_count,load_count,load_wr,i_clk,i_rst: in std_logic; sel_addr: in std_logic_vector(1 downto 0); o_address: out std_logic_vector(15 downto 0));
end entity;

architecture addr_prod_arch of addr_prod is
  component mux is
    generic (WIDTH: integer);
    port(d1,d2: in unsigned((WIDTH-1) downto 0); sel: in std_logic; o: out unsigned((WIDTH-1) downto 0));
  end component;
  component reg_pp is
    generic (WIDTH: integer);
    port(d: in unsigned((WIDTH-1) downto 0); clk,load,res: in std_logic; o: out unsigned((WIDTH-1) downto 0));
  end component;

  signal d1_MUX_count, o_MUX_count, addr_read, o_ADD_count, d_REG_wr, addr_offset, addr_write: unsigned(15 downto 0);

begin
  d1_MUX_count <= "0000000000000010";

  MUX_count: mux
  generic map (WIDTH => 16)
  port map (d1 => d1_MUX_count, d2 => o_ADD_count, sel => sel_count, o => o_MUX_count);

  REG_count: reg_pp
  generic map (WIDTH => 16)
  port map (d => o_MUX_count, clk => i_clk, load => load_count, res => i_rst, o => addr_read);

  o_ADD_count <= addr_read + "0000000000000001";

  ----

  REG_wr: reg_pp
  generic map (WIDTH => 16)
  port map (d => d_REG_wr, clk => i_clk, load => load_wr, res => i_rst, o => addr_offset);

  d_REG_wr <= addr_read - "0000000000000001";
  addr_write <= addr_offset + addr_read;

  -- Four-data-input MUX --
  with sel_addr select
    o_address <=
      "0000000000000000" when "00",
      "0000000000000001" when "01",
      std_logic_vector(addr_read) when "10",
      std_logic_vector(addr_write) when "11",
      (others => 'X') when others;
end architecture;

-------------------------------------------------------------------------------
-- Counter
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
  port (sel_rowc, load_rowc, load_nrows, sel_colc, load_colc, load_ncol, i_clk, i_rst: in std_logic; i_data: in std_logic_vector(7 downto 0); o_end: out std_logic);
end entity;

architecture counter_arch of counter is
  component mux is
    generic (WIDTH: integer);
    port(d1,d2: in unsigned((WIDTH-1) downto 0); sel: in std_logic; o: out unsigned((WIDTH-1) downto 0));
  end component;
  component reg_pp is
    generic (WIDTH: integer);
    port(d: in unsigned((WIDTH-1) downto 0); clk,load,res: in std_logic; o: out unsigned((WIDTH-1) downto 0));
  end component;

  signal o_COMP_rowc, sel_MUX_rowc: std_logic;
  signal curr_pixel_value, d2_MUX_rowc, o_MUX_rowc, n_row, o_ADD_rowc, tot_rows, d1_MUX_colc, o_MUX_colc, o_REG_colc, n_col, tot_col: unsigned(7 downto 0);

begin
  curr_pixel_value <= unsigned(i_data); -- casts i_data

  -- Rows counter
  REG_nrows: reg_pp
  generic map (WIDTH => 8)
  port map (d => curr_pixel_value, clk => i_clk, load => load_nrows, res => i_rst, o => tot_rows);

  d2_MUX_rowc <= "00000001";

  with sel_rowc select
    sel_MUX_rowc <= '1' when '0',
    o_COMP_rowc when '1',
    'X' when others;

  MUX_rowc: mux
  generic map (WIDTH => 8)
  port map (d1 => o_ADD_rowc, d2 => d2_MUX_rowc, sel => sel_MUX_rowc, o => o_MUX_rowc);

  REG_rowc: reg_pp
  generic map (WIDTH => 8)
  port map (d => o_MUX_rowc, clk => i_clk, load => load_rowc, res => i_rst, o => n_row);

  o_ADD_rowc <= n_row + "00000001";
  o_COMP_rowc <= '1' when n_row = tot_rows else '0';

  -- Columns counter
  REG_ncol: reg_pp
  generic map (WIDTH => 8)
  port map (d => curr_pixel_value, clk => i_clk, load => load_ncol, res => i_rst, o => tot_col);

  d1_MUX_colc <= "00000000";

  MUX_colc: mux
  generic map (WIDTH => 8)
  port map (d1 => d1_MUX_colc, d2 => n_col, sel => sel_colc, o => o_MUX_colc);

  REG_colc: reg_pp
  generic map (WIDTH => 8)
  port map (d => o_MUX_colc, clk => i_clk, load => load_colc, res => i_rst, o => o_REG_colc);

  n_col <= o_REG_colc + ("0000000" & o_COMP_rowc);
  o_end <= '1' when n_col = tot_col else '0';

end architecture;

-------------------------------------------------------------------------------
-- Datapath
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity datapath is
  port (i_clk,i_rst,sel_max,load_max,sel_min,load_min,sel_count,load_count,load_wr,sel_rowc,load_rowc,load_nrows,sel_colc,load_colc,load_ncol: in std_logic; i_data: in std_logic_vector(7 downto 0); sel_addr: in std_logic_vector(1 downto 0); o_address: out std_logic_vector(15 downto 0); o_data: out std_logic_vector(7 downto 0); o_end: out std_logic);
end entity;

architecture datapath_arch of datapath is
  component algo is
    port (sel_max,load_max,sel_min,load_min,i_clk,i_rst: in std_logic; i_data: in std_logic_vector(7 downto 0); o_data: out std_logic_vector(7 downto 0));
  end component;
  component addr_prod is
    port (sel_count,load_count,load_wr,i_clk,i_rst: in std_logic; sel_addr: in std_logic_vector(1 downto 0); o_address: out std_logic_vector(15 downto 0));
  end component;
  component counter is
    port (sel_rowc, load_rowc, load_nrows, sel_colc, load_colc, load_ncol, i_clk, i_rst: in std_logic; i_data: in std_logic_vector(7 downto 0); o_end: out std_logic);
  end component;
begin
  ALGO0: algo
  port map (sel_max,load_max,sel_min,load_min,i_clk,i_rst,i_data,o_data);

  ADDR_PROD0: addr_prod
  port map (sel_count,load_count,load_wr,i_clk,i_rst,sel_addr,o_address);

  COUNTER0: counter
  port map (sel_rowc, load_rowc, load_nrows, sel_colc, load_colc, load_ncol, i_clk, i_rst, i_data, o_end);

end architecture;

-------------------------------------------------------------------------------
-- Control Unit
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cu is
  port (i_clk,i_rst,i_start,o_end: in std_logic; i_data: in std_logic_vector(7 downto 0); o_done,o_en,o_we,sel_max,load_max,sel_min,load_min,sel_count,load_count,load_wr,sel_rowc,load_rowc,load_nrows,sel_colc,load_colc,load_ncol: out std_logic; sel_addr: out std_logic_vector(1 downto 0));
end entity;

architecture cu_arch of cu is
  type state is (s0,s1,s2,s3,s4,s5,s6,s7,s8,s9);
  signal curr_state, next_state: state;
begin

  -- Flip flops
  process (i_rst,i_clk)
  begin
    if (i_rst='1') then
      curr_state <= s0;
    elsif (rising_edge(i_clk)) then
      curr_state <= next_state;
    end if;
  end process;

  -- Next state function
  process (i_start,o_end,i_data,curr_state)
  begin
    next_state <= curr_state; -- makes sure the process is combinational

    case curr_state is
      when s0 =>
        if (i_start='0') then next_state <= s0;
      elsif (i_start='1') then next_state <= s1; -- not necessary, but useful for readability
        end if;
      when s1 =>
        next_state <= s2;
      when s2 =>
        if (i_data="00000000") then next_state <= s9;
        else next_state <= s3;
        end if;
      when s3 =>
        if (i_data="00000000") then next_state <= s9;
        else next_state <= s4;
        end if;
      when s4 =>
        if (o_end='0') then next_state <= s5;
        elsif (o_end='1') then next_state <= s6;
        end if;
      when s5 =>
        if (o_end='0') then next_state <= s5;
        elsif (o_end='1') then next_state <= s6;
        end if;
      when s6 =>
        next_state <= s7;
      when s7 =>
        next_state <= s8;
      when s8 =>
        if (o_end='0') then next_state <= s7;
        elsif (o_end='1') then next_state <= s9;
        end if;
      when s9 =>
        if (i_start='0') then next_state <= s0;
        elsif (i_start='1') then next_state <= s9;
        end if;
    end case;

  end process;

  -- Output function
  process (curr_state)
  begin
    -- Makes sure the process is combinational
    o_done <= '0';
    o_en <= '0';
    o_we <= '0';
    sel_max <= '0';
    load_max <= '0';
    sel_min <= '0';
    load_min <= '0';
    sel_count <= '0';
    load_count <= '0';
    load_wr <= '0';
    sel_rowc <= '0';
    load_rowc <= '0';
    load_nrows <= '0';
    sel_colc <= '0';
    load_colc <= '0';
    load_ncol  <= '0';
    sel_addr <= "00";

    case curr_state is
      when s0 =>
      when s1 =>
        o_en <= '1';
      when s2 =>
        o_en <= '1';
        ----
        load_nrows <= '1';
        sel_addr <= "01";
      when s3 =>
        -- sel_addr <= "01";
        ----
        load_ncol <= '1';
        load_rowc <= '1';
        load_colc <= '1';
        load_count <= '1';
      when s4 =>
        load_rowc <= '1';
        load_colc <= '1';
        load_count <= '1';
        ----
        o_en <= '1';
        load_max <= '1';
        load_min <= '1';
        sel_rowc <= '1';
        sel_colc <= '1';
        sel_count <= '1';
        load_wr <= '1';
        sel_addr <= "10";
      when s5 =>
        load_rowc <= '1';
        load_colc <= '1';
        load_count <= '1';
        o_en <= '1';
        load_max <= '1';
        load_min <= '1';
        sel_rowc <= '1';
        sel_colc <= '1';
        sel_count <= '1';
        load_wr <= '1';
        sel_addr <= "10";
        ----
        sel_max <= '1';
        sel_min <= '1';
      when s6 =>
        -- sel_addr <= "10";
        load_rowc <= '1';
        load_colc <= '1';
        load_count <= '1';
        load_max <= '1';
        load_min <= '1';
        sel_max <= '1';
        sel_min <= '1';
      when s7 =>
        -- sel_max <= '1';
        -- sel_min <= '1';
        ----
        sel_rowc <= '1';
        sel_colc <= '1';
        sel_count <= '1';
        o_en <= '1';
        sel_addr <= "10";
      when s8 =>
        sel_rowc <= '1';
        sel_colc <= '1';
        sel_count <= '1';
        o_en <= '1';
        ----
        o_we <= '1';
        load_rowc <= '1';
        load_colc <= '1';
        load_count <= '1';
        sel_addr <= "11";
      when s9 =>
        o_done <= '1';
    end case;

  end process;

end architecture;

-------------------------------------------------------------------------------
-- Final module
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity project_reti_logiche is
port (
      i_clk         : in  std_logic; -- cu & datapath input
      i_rst         : in  std_logic; -- cu & datapath input
      i_start       : in  std_logic;  -- cu input
      i_data        : in  std_logic_vector(7 downto 0); -- cu & datapath input
      o_address     : out std_logic_vector(15 downto 0); -- datapath output
      o_done        : out std_logic; -- cu output
      o_en          : out std_logic; -- cu output
      o_we          : out std_logic; -- cu output
      o_data        : out std_logic_vector (7 downto 0) -- datapath output
      );
end entity;

architecture project_reti_logiche_arch of project_reti_logiche is
  component cu is
    port (i_clk,i_rst,i_start,o_end: in std_logic; i_data: in std_logic_vector(7 downto 0); o_done,o_en,o_we,sel_max,load_max,sel_min,load_min,sel_count,load_count,load_wr,sel_rowc,load_rowc,load_nrows,sel_colc,load_colc,load_ncol: out std_logic; sel_addr: out std_logic_vector(1 downto 0));
  end component;
  component datapath is
    port (i_clk,i_rst,sel_max,load_max,sel_min,load_min,sel_count,load_count,load_wr,sel_rowc,load_rowc,load_nrows,sel_colc,load_colc,load_ncol: in std_logic; i_data: in std_logic_vector(7 downto 0); sel_addr: in std_logic_vector(1 downto 0); o_address: out std_logic_vector(15 downto 0); o_data: out std_logic_vector(7 downto 0); o_end: out std_logic);
  end component;

  -- Communication signals between control unit and processing unit
  signal o_end,sel_max,load_max,sel_min,load_min,sel_count,load_count,load_wr,sel_rowc,load_rowc,load_nrows,sel_colc,load_colc,load_ncol: std_logic;
  signal sel_addr: std_logic_vector(1 downto 0);

begin
  CU0: cu
  port map (i_clk,i_rst,i_start,o_end,i_data,o_done,o_en,o_we,sel_max,load_max,sel_min,load_min,sel_count,load_count,load_wr,sel_rowc,load_rowc,load_nrows,sel_colc,load_colc,load_ncol,sel_addr);

  DATAPATH0: datapath
  port map (i_clk,i_rst,sel_max,load_max,sel_min,load_min,sel_count,load_count,load_wr,sel_rowc,load_rowc,load_nrows,sel_colc,load_colc,load_ncol,i_data,sel_addr,o_address,o_data,o_end);

end architecture;
