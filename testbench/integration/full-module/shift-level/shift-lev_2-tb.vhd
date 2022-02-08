-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Alberto Boffi - Politecnico di Milano, AY 2020/21
-- TEST MODULE: Shift level = 2
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity shlev2_tb is
end shlev2_tb;

architecture shlev2tb of shlev2_tb is
constant c_CLOCK_PERIOD         : time := 15 ns;
signal   tb_done                : std_logic;
signal   mem_address            : std_logic_vector (15 downto 0) := (others => '0');
signal   tb_rst                 : std_logic := '0';
signal   tb_start               : std_logic := '0';
signal   tb_clk                 : std_logic := '0';
signal   mem_o_data,mem_i_data  : std_logic_vector (7 downto 0);
signal   enable_wire            : std_logic;
signal   mem_we                 : std_logic;

type ram_type is array (65535 downto 0) of std_logic_vector(7 downto 0);


signal RAM: ram_type :=
	(0 => std_logic_vector(to_unsigned(1, 8)),
	1 => std_logic_vector(to_unsigned(59, 8)),
	2 => std_logic_vector(to_unsigned(60, 8)),
	3 => std_logic_vector(to_unsigned(64, 8)),
	4 => std_logic_vector(to_unsigned(83, 8)),
	5 => std_logic_vector(to_unsigned(30, 8)),
	6 => std_logic_vector(to_unsigned(30, 8)),
	7 => std_logic_vector(to_unsigned(64, 8)),
	8 => std_logic_vector(to_unsigned(30, 8)),
	9 => std_logic_vector(to_unsigned(55, 8)),
	10 => std_logic_vector(to_unsigned(77, 8)),
	11 => std_logic_vector(to_unsigned(105, 8)),
	12 => std_logic_vector(to_unsigned(50, 8)),
	13 => std_logic_vector(to_unsigned(88, 8)),
	14 => std_logic_vector(to_unsigned(95, 8)),
	15 => std_logic_vector(to_unsigned(16, 8)),
	16 => std_logic_vector(to_unsigned(92, 8)),
	17 => std_logic_vector(to_unsigned(24, 8)),
	18 => std_logic_vector(to_unsigned(73, 8)),
	19 => std_logic_vector(to_unsigned(97, 8)),
	20 => std_logic_vector(to_unsigned(55, 8)),
	21 => std_logic_vector(to_unsigned(97, 8)),
	22 => std_logic_vector(to_unsigned(51, 8)),
	23 => std_logic_vector(to_unsigned(18, 8)),
	24 => std_logic_vector(to_unsigned(48, 8)),
	25 => std_logic_vector(to_unsigned(20, 8)),
	26 => std_logic_vector(to_unsigned(92, 8)),
	27 => std_logic_vector(to_unsigned(79, 8)),
	28 => std_logic_vector(to_unsigned(33, 8)),
	29 => std_logic_vector(to_unsigned(73, 8)),
	30 => std_logic_vector(to_unsigned(16, 8)),
	31 => std_logic_vector(to_unsigned(47, 8)),
	32 => std_logic_vector(to_unsigned(18, 8)),
	33 => std_logic_vector(to_unsigned(53, 8)),
	34 => std_logic_vector(to_unsigned(93, 8)),
	35 => std_logic_vector(to_unsigned(37, 8)),
	36 => std_logic_vector(to_unsigned(46, 8)),
	37 => std_logic_vector(to_unsigned(73, 8)),
	38 => std_logic_vector(to_unsigned(65, 8)),
	39 => std_logic_vector(to_unsigned(29, 8)),
	40 => std_logic_vector(to_unsigned(74, 8)),
	41 => std_logic_vector(to_unsigned(65, 8)),
	42 => std_logic_vector(to_unsigned(59, 8)),
	43 => std_logic_vector(to_unsigned(50, 8)),
	44 => std_logic_vector(to_unsigned(69, 8)),
	45 => std_logic_vector(to_unsigned(63, 8)),
	46 => std_logic_vector(to_unsigned(81, 8)),
	47 => std_logic_vector(to_unsigned(29, 8)),
	48 => std_logic_vector(to_unsigned(29, 8)),
	49 => std_logic_vector(to_unsigned(88, 8)),
	50 => std_logic_vector(to_unsigned(99, 8)),
	51 => std_logic_vector(to_unsigned(64, 8)),
	52 => std_logic_vector(to_unsigned(34, 8)),
	53 => std_logic_vector(to_unsigned(23, 8)),
	54 => std_logic_vector(to_unsigned(94, 8)),
	55 => std_logic_vector(to_unsigned(57, 8)),
	56 => std_logic_vector(to_unsigned(79, 8)),
	57 => std_logic_vector(to_unsigned(72, 8)),
	58 => std_logic_vector(to_unsigned(97, 8)),
	59 => std_logic_vector(to_unsigned(48, 8)),
	60 => std_logic_vector(to_unsigned(72, 8)),
	others =>(others =>'0'));

component project_reti_logiche is
port (
      i_clk         : in  std_logic;
      i_rst         : in  std_logic;
      i_start       : in  std_logic;
      i_data        : in  std_logic_vector(7 downto 0);
      o_address     : out std_logic_vector(15 downto 0);
      o_done        : out std_logic;
      o_en          : out std_logic;
      o_we          : out std_logic;
      o_data        : out std_logic_vector (7 downto 0)
      );
end component project_reti_logiche;


begin
UUT: project_reti_logiche
port map (
          i_clk      	=> tb_clk,
          i_rst      	=> tb_rst,
          i_start       => tb_start,
          i_data    	=> mem_o_data,
          o_address  	=> mem_address,
          o_done      	=> tb_done,
          o_en   	=> enable_wire,
          o_we 		=> mem_we,
          o_data    	=> mem_i_data
          );

p_CLK_GEN : process is
begin
    wait for c_CLOCK_PERIOD/2;
    tb_clk <= not tb_clk;
end process p_CLK_GEN;


MEM : process(tb_clk)
begin
    if tb_clk'event and tb_clk = '1' then
        if enable_wire = '1' then
            if mem_we = '1' then
                RAM(conv_integer(mem_address))  <= mem_i_data;
                mem_o_data                      <= mem_i_data after 1 ns;
            else
                mem_o_data <= RAM(conv_integer(mem_address)) after 1 ns;
            end if;
        end if;
    end if;
end process;


test : process is
begin
    wait for 100 ns;
    -- wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    -- wait for c_CLOCK_PERIOD;
    -- wait for 100 ns;
    wait for 10 ns;
    tb_rst <= '0';
    -- wait for c_CLOCK_PERIOD;
    -- wait for 100 ns;
    tb_start <= '1';
    -- wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    -- wait for c_CLOCK_PERIOD;
    wait for 10 ns;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;

    assert RAM(61) = std_logic_vector(to_unsigned(176, 8)) report "TEST FALLITO (WORKING ZONE). Expected 176 found " & integer'image(to_integer(unsigned(RAM(61)))) severity failure;
    assert RAM(62) = std_logic_vector(to_unsigned(192, 8)) report "TEST FALLITO (WORKING ZONE). Expected 192 found " & integer'image(to_integer(unsigned(RAM(62)))) severity failure;
    assert RAM(63) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(63)))) severity failure;
    assert RAM(64) = std_logic_vector(to_unsigned(56, 8)) report "TEST FALLITO (WORKING ZONE). Expected 56 found " & integer'image(to_integer(unsigned(RAM(64)))) severity failure;
    assert RAM(65) = std_logic_vector(to_unsigned(56, 8)) report "TEST FALLITO (WORKING ZONE). Expected 56 found " & integer'image(to_integer(unsigned(RAM(65)))) severity failure;
    assert RAM(66) = std_logic_vector(to_unsigned(192, 8)) report "TEST FALLITO (WORKING ZONE). Expected 192 found " & integer'image(to_integer(unsigned(RAM(66)))) severity failure;
    assert RAM(67) = std_logic_vector(to_unsigned(56, 8)) report "TEST FALLITO (WORKING ZONE). Expected 56 found " & integer'image(to_integer(unsigned(RAM(67)))) severity failure;
    assert RAM(68) = std_logic_vector(to_unsigned(156, 8)) report "TEST FALLITO (WORKING ZONE). Expected 156 found " & integer'image(to_integer(unsigned(RAM(68)))) severity failure;
    assert RAM(69) = std_logic_vector(to_unsigned(244, 8)) report "TEST FALLITO (WORKING ZONE). Expected 244 found " & integer'image(to_integer(unsigned(RAM(69)))) severity failure;
    assert RAM(70) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(70)))) severity failure;
    assert RAM(71) = std_logic_vector(to_unsigned(136, 8)) report "TEST FALLITO (WORKING ZONE). Expected 136 found " & integer'image(to_integer(unsigned(RAM(71)))) severity failure;
    assert RAM(72) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(72)))) severity failure;
    assert RAM(73) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(73)))) severity failure;
    assert RAM(74) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(74)))) severity failure;
    assert RAM(75) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(75)))) severity failure;
    assert RAM(76) = std_logic_vector(to_unsigned(32, 8)) report "TEST FALLITO (WORKING ZONE). Expected 32 found " & integer'image(to_integer(unsigned(RAM(76)))) severity failure;
    assert RAM(77) = std_logic_vector(to_unsigned(228, 8)) report "TEST FALLITO (WORKING ZONE). Expected 228 found " & integer'image(to_integer(unsigned(RAM(77)))) severity failure;
    assert RAM(78) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(78)))) severity failure;
    assert RAM(79) = std_logic_vector(to_unsigned(156, 8)) report "TEST FALLITO (WORKING ZONE). Expected 156 found " & integer'image(to_integer(unsigned(RAM(79)))) severity failure;
    assert RAM(80) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(80)))) severity failure;
    assert RAM(81) = std_logic_vector(to_unsigned(140, 8)) report "TEST FALLITO (WORKING ZONE). Expected 140 found " & integer'image(to_integer(unsigned(RAM(81)))) severity failure;
    assert RAM(82) = std_logic_vector(to_unsigned(8, 8)) report "TEST FALLITO (WORKING ZONE). Expected 8 found " & integer'image(to_integer(unsigned(RAM(82)))) severity failure;
    assert RAM(83) = std_logic_vector(to_unsigned(128, 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM(83)))) severity failure;
    assert RAM(84) = std_logic_vector(to_unsigned(16, 8)) report "TEST FALLITO (WORKING ZONE). Expected 16 found " & integer'image(to_integer(unsigned(RAM(84)))) severity failure;
    assert RAM(85) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(85)))) severity failure;
    assert RAM(86) = std_logic_vector(to_unsigned(252, 8)) report "TEST FALLITO (WORKING ZONE). Expected 252 found " & integer'image(to_integer(unsigned(RAM(86)))) severity failure;
    assert RAM(87) = std_logic_vector(to_unsigned(68, 8)) report "TEST FALLITO (WORKING ZONE). Expected 68 found " & integer'image(to_integer(unsigned(RAM(87)))) severity failure;
    assert RAM(88) = std_logic_vector(to_unsigned(228, 8)) report "TEST FALLITO (WORKING ZONE). Expected 228 found " & integer'image(to_integer(unsigned(RAM(88)))) severity failure;
    assert RAM(89) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(89)))) severity failure;
    assert RAM(90) = std_logic_vector(to_unsigned(124, 8)) report "TEST FALLITO (WORKING ZONE). Expected 124 found " & integer'image(to_integer(unsigned(RAM(90)))) severity failure;
    assert RAM(91) = std_logic_vector(to_unsigned(8, 8)) report "TEST FALLITO (WORKING ZONE). Expected 8 found " & integer'image(to_integer(unsigned(RAM(91)))) severity failure;
    assert RAM(92) = std_logic_vector(to_unsigned(148, 8)) report "TEST FALLITO (WORKING ZONE). Expected 148 found " & integer'image(to_integer(unsigned(RAM(92)))) severity failure;
    assert RAM(93) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(93)))) severity failure;
    assert RAM(94) = std_logic_vector(to_unsigned(84, 8)) report "TEST FALLITO (WORKING ZONE). Expected 84 found " & integer'image(to_integer(unsigned(RAM(94)))) severity failure;
    assert RAM(95) = std_logic_vector(to_unsigned(120, 8)) report "TEST FALLITO (WORKING ZONE). Expected 120 found " & integer'image(to_integer(unsigned(RAM(95)))) severity failure;
    assert RAM(96) = std_logic_vector(to_unsigned(228, 8)) report "TEST FALLITO (WORKING ZONE). Expected 228 found " & integer'image(to_integer(unsigned(RAM(96)))) severity failure;
    assert RAM(97) = std_logic_vector(to_unsigned(196, 8)) report "TEST FALLITO (WORKING ZONE). Expected 196 found " & integer'image(to_integer(unsigned(RAM(97)))) severity failure;
    assert RAM(98) = std_logic_vector(to_unsigned(52, 8)) report "TEST FALLITO (WORKING ZONE). Expected 52 found " & integer'image(to_integer(unsigned(RAM(98)))) severity failure;
    assert RAM(99) = std_logic_vector(to_unsigned(232, 8)) report "TEST FALLITO (WORKING ZONE). Expected 232 found " & integer'image(to_integer(unsigned(RAM(99)))) severity failure;
    assert RAM(100) = std_logic_vector(to_unsigned(196, 8)) report "TEST FALLITO (WORKING ZONE). Expected 196 found " & integer'image(to_integer(unsigned(RAM(100)))) severity failure;
    assert RAM(101) = std_logic_vector(to_unsigned(172, 8)) report "TEST FALLITO (WORKING ZONE). Expected 172 found " & integer'image(to_integer(unsigned(RAM(101)))) severity failure;
    assert RAM(102) = std_logic_vector(to_unsigned(136, 8)) report "TEST FALLITO (WORKING ZONE). Expected 136 found " & integer'image(to_integer(unsigned(RAM(102)))) severity failure;
    assert RAM(103) = std_logic_vector(to_unsigned(212, 8)) report "TEST FALLITO (WORKING ZONE). Expected 212 found " & integer'image(to_integer(unsigned(RAM(103)))) severity failure;
    assert RAM(104) = std_logic_vector(to_unsigned(188, 8)) report "TEST FALLITO (WORKING ZONE). Expected 188 found " & integer'image(to_integer(unsigned(RAM(104)))) severity failure;
    assert RAM(105) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(105)))) severity failure;
    assert RAM(106) = std_logic_vector(to_unsigned(52, 8)) report "TEST FALLITO (WORKING ZONE). Expected 52 found " & integer'image(to_integer(unsigned(RAM(106)))) severity failure;
    assert RAM(107) = std_logic_vector(to_unsigned(52, 8)) report "TEST FALLITO (WORKING ZONE). Expected 52 found " & integer'image(to_integer(unsigned(RAM(107)))) severity failure;
    assert RAM(108) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(108)))) severity failure;
    assert RAM(109) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(109)))) severity failure;
    assert RAM(110) = std_logic_vector(to_unsigned(192, 8)) report "TEST FALLITO (WORKING ZONE). Expected 192 found " & integer'image(to_integer(unsigned(RAM(110)))) severity failure;
    assert RAM(111) = std_logic_vector(to_unsigned(72, 8)) report "TEST FALLITO (WORKING ZONE). Expected 72 found " & integer'image(to_integer(unsigned(RAM(111)))) severity failure;
    assert RAM(112) = std_logic_vector(to_unsigned(28, 8)) report "TEST FALLITO (WORKING ZONE). Expected 28 found " & integer'image(to_integer(unsigned(RAM(112)))) severity failure;
    assert RAM(113) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(113)))) severity failure;
    assert RAM(114) = std_logic_vector(to_unsigned(164, 8)) report "TEST FALLITO (WORKING ZONE). Expected 164 found " & integer'image(to_integer(unsigned(RAM(114)))) severity failure;
    assert RAM(115) = std_logic_vector(to_unsigned(252, 8)) report "TEST FALLITO (WORKING ZONE). Expected 252 found " & integer'image(to_integer(unsigned(RAM(115)))) severity failure;
    assert RAM(116) = std_logic_vector(to_unsigned(224, 8)) report "TEST FALLITO (WORKING ZONE). Expected 224 found " & integer'image(to_integer(unsigned(RAM(116)))) severity failure;
    assert RAM(117) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(117)))) severity failure;
    assert RAM(118) = std_logic_vector(to_unsigned(128, 8)) report "TEST FALLITO (WORKING ZONE). Expected 128 found " & integer'image(to_integer(unsigned(RAM(118)))) severity failure;
    assert RAM(119) = std_logic_vector(to_unsigned(224, 8)) report "TEST FALLITO (WORKING ZONE). Expected 224 found " & integer'image(to_integer(unsigned(RAM(119)))) severity failure;

    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end shlev2tb;
