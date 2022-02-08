-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Alberto Boffi - Politecnico di Milano, AY 2020/21
-- TEST MODULE: Max contrast
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity maxcont_tb is
end maxcont_tb;

architecture maxconttb of maxcont_tb is
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
	(0 => std_logic_vector(to_unsigned(27, 8)),
	1 => std_logic_vector(to_unsigned(5, 8)),
	2 => std_logic_vector(to_unsigned(28, 8)),
	3 => std_logic_vector(to_unsigned(247, 8)),
	4 => std_logic_vector(to_unsigned(170, 8)),
	5 => std_logic_vector(to_unsigned(245, 8)),
	6 => std_logic_vector(to_unsigned(253, 8)),
	7 => std_logic_vector(to_unsigned(57, 8)),
	8 => std_logic_vector(to_unsigned(150, 8)),
	9 => std_logic_vector(to_unsigned(39, 8)),
	10 => std_logic_vector(to_unsigned(116, 8)),
	11 => std_logic_vector(to_unsigned(46, 8)),
	12 => std_logic_vector(to_unsigned(125, 8)),
	13 => std_logic_vector(to_unsigned(68, 8)),
	14 => std_logic_vector(to_unsigned(246, 8)),
	15 => std_logic_vector(to_unsigned(144, 8)),
	16 => std_logic_vector(to_unsigned(82, 8)),
	17 => std_logic_vector(to_unsigned(216, 8)),
	18 => std_logic_vector(to_unsigned(62, 8)),
	19 => std_logic_vector(to_unsigned(148, 8)),
	20 => std_logic_vector(to_unsigned(89, 8)),
	21 => std_logic_vector(to_unsigned(71, 8)),
	22 => std_logic_vector(to_unsigned(19, 8)),
	23 => std_logic_vector(to_unsigned(219, 8)),
	24 => std_logic_vector(to_unsigned(116, 8)),
	25 => std_logic_vector(to_unsigned(85, 8)),
	26 => std_logic_vector(to_unsigned(206, 8)),
	27 => std_logic_vector(to_unsigned(188, 8)),
	28 => std_logic_vector(to_unsigned(33, 8)),
	29 => std_logic_vector(to_unsigned(95, 8)),
	30 => std_logic_vector(to_unsigned(79, 8)),
	31 => std_logic_vector(to_unsigned(39, 8)),
	32 => std_logic_vector(to_unsigned(15, 8)),
	33 => std_logic_vector(to_unsigned(226, 8)),
	34 => std_logic_vector(to_unsigned(251, 8)),
	35 => std_logic_vector(to_unsigned(42, 8)),
	36 => std_logic_vector(to_unsigned(165, 8)),
	37 => std_logic_vector(to_unsigned(46, 8)),
	38 => std_logic_vector(to_unsigned(41, 8)),
	39 => std_logic_vector(to_unsigned(167, 8)),
	40 => std_logic_vector(to_unsigned(133, 8)),
	41 => std_logic_vector(to_unsigned(69, 8)),
	42 => std_logic_vector(to_unsigned(64, 8)),
	43 => std_logic_vector(to_unsigned(220, 8)),
	44 => std_logic_vector(to_unsigned(181, 8)),
	45 => std_logic_vector(to_unsigned(245, 8)),
	46 => std_logic_vector(to_unsigned(240, 8)),
	47 => std_logic_vector(to_unsigned(213, 8)),
	48 => std_logic_vector(to_unsigned(155, 8)),
	49 => std_logic_vector(to_unsigned(22, 8)),
	50 => std_logic_vector(to_unsigned(135, 8)),
	51 => std_logic_vector(to_unsigned(226, 8)),
	52 => std_logic_vector(to_unsigned(59, 8)),
	53 => std_logic_vector(to_unsigned(124, 8)),
	54 => std_logic_vector(to_unsigned(103, 8)),
	55 => std_logic_vector(to_unsigned(149, 8)),
	56 => std_logic_vector(to_unsigned(27, 8)),
	57 => std_logic_vector(to_unsigned(70, 8)),
	58 => std_logic_vector(to_unsigned(87, 8)),
	59 => std_logic_vector(to_unsigned(109, 8)),
	60 => std_logic_vector(to_unsigned(38, 8)),
	61 => std_logic_vector(to_unsigned(23, 8)),
	62 => std_logic_vector(to_unsigned(243, 8)),
	63 => std_logic_vector(to_unsigned(143, 8)),
	64 => std_logic_vector(to_unsigned(173, 8)),
	65 => std_logic_vector(to_unsigned(16, 8)),
	66 => std_logic_vector(to_unsigned(84, 8)),
	67 => std_logic_vector(to_unsigned(72, 8)),
	68 => std_logic_vector(to_unsigned(189, 8)),
	69 => std_logic_vector(to_unsigned(152, 8)),
	70 => std_logic_vector(to_unsigned(152, 8)),
	71 => std_logic_vector(to_unsigned(212, 8)),
	72 => std_logic_vector(to_unsigned(72, 8)),
	73 => std_logic_vector(to_unsigned(13, 8)),
	74 => std_logic_vector(to_unsigned(70, 8)),
	75 => std_logic_vector(to_unsigned(182, 8)),
	76 => std_logic_vector(to_unsigned(61, 8)),
	77 => std_logic_vector(to_unsigned(216, 8)),
	78 => std_logic_vector(to_unsigned(64, 8)),
	79 => std_logic_vector(to_unsigned(245, 8)),
	80 => std_logic_vector(to_unsigned(139, 8)),
	81 => std_logic_vector(to_unsigned(19, 8)),
	82 => std_logic_vector(to_unsigned(140, 8)),
	83 => std_logic_vector(to_unsigned(61, 8)),
	84 => std_logic_vector(to_unsigned(224, 8)),
	85 => std_logic_vector(to_unsigned(57, 8)),
	86 => std_logic_vector(to_unsigned(123, 8)),
	87 => std_logic_vector(to_unsigned(30, 8)),
	88 => std_logic_vector(to_unsigned(214, 8)),
	89 => std_logic_vector(to_unsigned(159, 8)),
	90 => std_logic_vector(to_unsigned(102, 8)),
	91 => std_logic_vector(to_unsigned(0, 8)),
	92 => std_logic_vector(to_unsigned(108, 8)),
	93 => std_logic_vector(to_unsigned(220, 8)),
	94 => std_logic_vector(to_unsigned(22, 8)),
	95 => std_logic_vector(to_unsigned(160, 8)),
	96 => std_logic_vector(to_unsigned(198, 8)),
	97 => std_logic_vector(to_unsigned(241, 8)),
	98 => std_logic_vector(to_unsigned(33, 8)),
	99 => std_logic_vector(to_unsigned(109, 8)),
	100 => std_logic_vector(to_unsigned(65, 8)),
	101 => std_logic_vector(to_unsigned(97, 8)),
	102 => std_logic_vector(to_unsigned(225, 8)),
	103 => std_logic_vector(to_unsigned(73, 8)),
	104 => std_logic_vector(to_unsigned(254, 8)),
	105 => std_logic_vector(to_unsigned(5, 8)),
	106 => std_logic_vector(to_unsigned(249, 8)),
	107 => std_logic_vector(to_unsigned(120, 8)),
	108 => std_logic_vector(to_unsigned(95, 8)),
	109 => std_logic_vector(to_unsigned(30, 8)),
	110 => std_logic_vector(to_unsigned(209, 8)),
	111 => std_logic_vector(to_unsigned(19, 8)),
	112 => std_logic_vector(to_unsigned(23, 8)),
	113 => std_logic_vector(to_unsigned(3, 8)),
	114 => std_logic_vector(to_unsigned(59, 8)),
	115 => std_logic_vector(to_unsigned(234, 8)),
	116 => std_logic_vector(to_unsigned(0, 8)),
	117 => std_logic_vector(to_unsigned(232, 8)),
	118 => std_logic_vector(to_unsigned(41, 8)),
	119 => std_logic_vector(to_unsigned(203, 8)),
	120 => std_logic_vector(to_unsigned(73, 8)),
	121 => std_logic_vector(to_unsigned(252, 8)),
	122 => std_logic_vector(to_unsigned(255, 8)),
	123 => std_logic_vector(to_unsigned(214, 8)),
	124 => std_logic_vector(to_unsigned(29, 8)),
	125 => std_logic_vector(to_unsigned(116, 8)),
	126 => std_logic_vector(to_unsigned(108, 8)),
	127 => std_logic_vector(to_unsigned(1, 8)),
	128 => std_logic_vector(to_unsigned(24, 8)),
	129 => std_logic_vector(to_unsigned(64, 8)),
	130 => std_logic_vector(to_unsigned(38, 8)),
	131 => std_logic_vector(to_unsigned(22, 8)),
	132 => std_logic_vector(to_unsigned(15, 8)),
	133 => std_logic_vector(to_unsigned(134, 8)),
	134 => std_logic_vector(to_unsigned(169, 8)),
	135 => std_logic_vector(to_unsigned(59, 8)),
	136 => std_logic_vector(to_unsigned(168, 8)),
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
    wait for c_CLOCK_PERIOD;
    tb_rst <= '1';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_rst <= '0';
    wait for c_CLOCK_PERIOD;
    wait for 100 ns;
    tb_start <= '1';
    wait for c_CLOCK_PERIOD;
    wait until tb_done = '1';
    wait for c_CLOCK_PERIOD;
    tb_start <= '0';
    wait until tb_done = '0';
    wait for 100 ns;

    assert RAM(137) = std_logic_vector(to_unsigned(28, 8)) report "TEST FALLITO (WORKING ZONE). Expected 28 found " & integer'image(to_integer(unsigned(RAM(137)))) severity failure;
    assert RAM(138) = std_logic_vector(to_unsigned(247, 8)) report "TEST FALLITO (WORKING ZONE). Expected 247 found " & integer'image(to_integer(unsigned(RAM(138)))) severity failure;
    assert RAM(139) = std_logic_vector(to_unsigned(170, 8)) report "TEST FALLITO (WORKING ZONE). Expected 170 found " & integer'image(to_integer(unsigned(RAM(139)))) severity failure;
    assert RAM(140) = std_logic_vector(to_unsigned(245, 8)) report "TEST FALLITO (WORKING ZONE). Expected 245 found " & integer'image(to_integer(unsigned(RAM(140)))) severity failure;
    assert RAM(141) = std_logic_vector(to_unsigned(253, 8)) report "TEST FALLITO (WORKING ZONE). Expected 253 found " & integer'image(to_integer(unsigned(RAM(141)))) severity failure;
    assert RAM(142) = std_logic_vector(to_unsigned(57, 8)) report "TEST FALLITO (WORKING ZONE). Expected 57 found " & integer'image(to_integer(unsigned(RAM(142)))) severity failure;
    assert RAM(143) = std_logic_vector(to_unsigned(150, 8)) report "TEST FALLITO (WORKING ZONE). Expected 150 found " & integer'image(to_integer(unsigned(RAM(143)))) severity failure;
    assert RAM(144) = std_logic_vector(to_unsigned(39, 8)) report "TEST FALLITO (WORKING ZONE). Expected 39 found " & integer'image(to_integer(unsigned(RAM(144)))) severity failure;
    assert RAM(145) = std_logic_vector(to_unsigned(116, 8)) report "TEST FALLITO (WORKING ZONE). Expected 116 found " & integer'image(to_integer(unsigned(RAM(145)))) severity failure;
    assert RAM(146) = std_logic_vector(to_unsigned(46, 8)) report "TEST FALLITO (WORKING ZONE). Expected 46 found " & integer'image(to_integer(unsigned(RAM(146)))) severity failure;
    assert RAM(147) = std_logic_vector(to_unsigned(125, 8)) report "TEST FALLITO (WORKING ZONE). Expected 125 found " & integer'image(to_integer(unsigned(RAM(147)))) severity failure;
    assert RAM(148) = std_logic_vector(to_unsigned(68, 8)) report "TEST FALLITO (WORKING ZONE). Expected 68 found " & integer'image(to_integer(unsigned(RAM(148)))) severity failure;
    assert RAM(149) = std_logic_vector(to_unsigned(246, 8)) report "TEST FALLITO (WORKING ZONE). Expected 246 found " & integer'image(to_integer(unsigned(RAM(149)))) severity failure;
    assert RAM(150) = std_logic_vector(to_unsigned(144, 8)) report "TEST FALLITO (WORKING ZONE). Expected 144 found " & integer'image(to_integer(unsigned(RAM(150)))) severity failure;
    assert RAM(151) = std_logic_vector(to_unsigned(82, 8)) report "TEST FALLITO (WORKING ZONE). Expected 82 found " & integer'image(to_integer(unsigned(RAM(151)))) severity failure;
    assert RAM(152) = std_logic_vector(to_unsigned(216, 8)) report "TEST FALLITO (WORKING ZONE). Expected 216 found " & integer'image(to_integer(unsigned(RAM(152)))) severity failure;
    assert RAM(153) = std_logic_vector(to_unsigned(62, 8)) report "TEST FALLITO (WORKING ZONE). Expected 62 found " & integer'image(to_integer(unsigned(RAM(153)))) severity failure;
    assert RAM(154) = std_logic_vector(to_unsigned(148, 8)) report "TEST FALLITO (WORKING ZONE). Expected 148 found " & integer'image(to_integer(unsigned(RAM(154)))) severity failure;
    assert RAM(155) = std_logic_vector(to_unsigned(89, 8)) report "TEST FALLITO (WORKING ZONE). Expected 89 found " & integer'image(to_integer(unsigned(RAM(155)))) severity failure;
    assert RAM(156) = std_logic_vector(to_unsigned(71, 8)) report "TEST FALLITO (WORKING ZONE). Expected 71 found " & integer'image(to_integer(unsigned(RAM(156)))) severity failure;
    assert RAM(157) = std_logic_vector(to_unsigned(19, 8)) report "TEST FALLITO (WORKING ZONE). Expected 19 found " & integer'image(to_integer(unsigned(RAM(157)))) severity failure;
    assert RAM(158) = std_logic_vector(to_unsigned(219, 8)) report "TEST FALLITO (WORKING ZONE). Expected 219 found " & integer'image(to_integer(unsigned(RAM(158)))) severity failure;
    assert RAM(159) = std_logic_vector(to_unsigned(116, 8)) report "TEST FALLITO (WORKING ZONE). Expected 116 found " & integer'image(to_integer(unsigned(RAM(159)))) severity failure;
    assert RAM(160) = std_logic_vector(to_unsigned(85, 8)) report "TEST FALLITO (WORKING ZONE). Expected 85 found " & integer'image(to_integer(unsigned(RAM(160)))) severity failure;
    assert RAM(161) = std_logic_vector(to_unsigned(206, 8)) report "TEST FALLITO (WORKING ZONE). Expected 206 found " & integer'image(to_integer(unsigned(RAM(161)))) severity failure;
    assert RAM(162) = std_logic_vector(to_unsigned(188, 8)) report "TEST FALLITO (WORKING ZONE). Expected 188 found " & integer'image(to_integer(unsigned(RAM(162)))) severity failure;
    assert RAM(163) = std_logic_vector(to_unsigned(33, 8)) report "TEST FALLITO (WORKING ZONE). Expected 33 found " & integer'image(to_integer(unsigned(RAM(163)))) severity failure;
    assert RAM(164) = std_logic_vector(to_unsigned(95, 8)) report "TEST FALLITO (WORKING ZONE). Expected 95 found " & integer'image(to_integer(unsigned(RAM(164)))) severity failure;
    assert RAM(165) = std_logic_vector(to_unsigned(79, 8)) report "TEST FALLITO (WORKING ZONE). Expected 79 found " & integer'image(to_integer(unsigned(RAM(165)))) severity failure;
    assert RAM(166) = std_logic_vector(to_unsigned(39, 8)) report "TEST FALLITO (WORKING ZONE). Expected 39 found " & integer'image(to_integer(unsigned(RAM(166)))) severity failure;
    assert RAM(167) = std_logic_vector(to_unsigned(15, 8)) report "TEST FALLITO (WORKING ZONE). Expected 15 found " & integer'image(to_integer(unsigned(RAM(167)))) severity failure;
    assert RAM(168) = std_logic_vector(to_unsigned(226, 8)) report "TEST FALLITO (WORKING ZONE). Expected 226 found " & integer'image(to_integer(unsigned(RAM(168)))) severity failure;
    assert RAM(169) = std_logic_vector(to_unsigned(251, 8)) report "TEST FALLITO (WORKING ZONE). Expected 251 found " & integer'image(to_integer(unsigned(RAM(169)))) severity failure;
    assert RAM(170) = std_logic_vector(to_unsigned(42, 8)) report "TEST FALLITO (WORKING ZONE). Expected 42 found " & integer'image(to_integer(unsigned(RAM(170)))) severity failure;
    assert RAM(171) = std_logic_vector(to_unsigned(165, 8)) report "TEST FALLITO (WORKING ZONE). Expected 165 found " & integer'image(to_integer(unsigned(RAM(171)))) severity failure;
    assert RAM(172) = std_logic_vector(to_unsigned(46, 8)) report "TEST FALLITO (WORKING ZONE). Expected 46 found " & integer'image(to_integer(unsigned(RAM(172)))) severity failure;
    assert RAM(173) = std_logic_vector(to_unsigned(41, 8)) report "TEST FALLITO (WORKING ZONE). Expected 41 found " & integer'image(to_integer(unsigned(RAM(173)))) severity failure;
    assert RAM(174) = std_logic_vector(to_unsigned(167, 8)) report "TEST FALLITO (WORKING ZONE). Expected 167 found " & integer'image(to_integer(unsigned(RAM(174)))) severity failure;
    assert RAM(175) = std_logic_vector(to_unsigned(133, 8)) report "TEST FALLITO (WORKING ZONE). Expected 133 found " & integer'image(to_integer(unsigned(RAM(175)))) severity failure;
    assert RAM(176) = std_logic_vector(to_unsigned(69, 8)) report "TEST FALLITO (WORKING ZONE). Expected 69 found " & integer'image(to_integer(unsigned(RAM(176)))) severity failure;
    assert RAM(177) = std_logic_vector(to_unsigned(64, 8)) report "TEST FALLITO (WORKING ZONE). Expected 64 found " & integer'image(to_integer(unsigned(RAM(177)))) severity failure;
    assert RAM(178) = std_logic_vector(to_unsigned(220, 8)) report "TEST FALLITO (WORKING ZONE). Expected 220 found " & integer'image(to_integer(unsigned(RAM(178)))) severity failure;
    assert RAM(179) = std_logic_vector(to_unsigned(181, 8)) report "TEST FALLITO (WORKING ZONE). Expected 181 found " & integer'image(to_integer(unsigned(RAM(179)))) severity failure;
    assert RAM(180) = std_logic_vector(to_unsigned(245, 8)) report "TEST FALLITO (WORKING ZONE). Expected 245 found " & integer'image(to_integer(unsigned(RAM(180)))) severity failure;
    assert RAM(181) = std_logic_vector(to_unsigned(240, 8)) report "TEST FALLITO (WORKING ZONE). Expected 240 found " & integer'image(to_integer(unsigned(RAM(181)))) severity failure;
    assert RAM(182) = std_logic_vector(to_unsigned(213, 8)) report "TEST FALLITO (WORKING ZONE). Expected 213 found " & integer'image(to_integer(unsigned(RAM(182)))) severity failure;
    assert RAM(183) = std_logic_vector(to_unsigned(155, 8)) report "TEST FALLITO (WORKING ZONE). Expected 155 found " & integer'image(to_integer(unsigned(RAM(183)))) severity failure;
    assert RAM(184) = std_logic_vector(to_unsigned(22, 8)) report "TEST FALLITO (WORKING ZONE). Expected 22 found " & integer'image(to_integer(unsigned(RAM(184)))) severity failure;
    assert RAM(185) = std_logic_vector(to_unsigned(135, 8)) report "TEST FALLITO (WORKING ZONE). Expected 135 found " & integer'image(to_integer(unsigned(RAM(185)))) severity failure;
    assert RAM(186) = std_logic_vector(to_unsigned(226, 8)) report "TEST FALLITO (WORKING ZONE). Expected 226 found " & integer'image(to_integer(unsigned(RAM(186)))) severity failure;
    assert RAM(187) = std_logic_vector(to_unsigned(59, 8)) report "TEST FALLITO (WORKING ZONE). Expected 59 found " & integer'image(to_integer(unsigned(RAM(187)))) severity failure;
    assert RAM(188) = std_logic_vector(to_unsigned(124, 8)) report "TEST FALLITO (WORKING ZONE). Expected 124 found " & integer'image(to_integer(unsigned(RAM(188)))) severity failure;
    assert RAM(189) = std_logic_vector(to_unsigned(103, 8)) report "TEST FALLITO (WORKING ZONE). Expected 103 found " & integer'image(to_integer(unsigned(RAM(189)))) severity failure;
    assert RAM(190) = std_logic_vector(to_unsigned(149, 8)) report "TEST FALLITO (WORKING ZONE). Expected 149 found " & integer'image(to_integer(unsigned(RAM(190)))) severity failure;
    assert RAM(191) = std_logic_vector(to_unsigned(27, 8)) report "TEST FALLITO (WORKING ZONE). Expected 27 found " & integer'image(to_integer(unsigned(RAM(191)))) severity failure;
    assert RAM(192) = std_logic_vector(to_unsigned(70, 8)) report "TEST FALLITO (WORKING ZONE). Expected 70 found " & integer'image(to_integer(unsigned(RAM(192)))) severity failure;
    assert RAM(193) = std_logic_vector(to_unsigned(87, 8)) report "TEST FALLITO (WORKING ZONE). Expected 87 found " & integer'image(to_integer(unsigned(RAM(193)))) severity failure;
    assert RAM(194) = std_logic_vector(to_unsigned(109, 8)) report "TEST FALLITO (WORKING ZONE). Expected 109 found " & integer'image(to_integer(unsigned(RAM(194)))) severity failure;
    assert RAM(195) = std_logic_vector(to_unsigned(38, 8)) report "TEST FALLITO (WORKING ZONE). Expected 38 found " & integer'image(to_integer(unsigned(RAM(195)))) severity failure;
    assert RAM(196) = std_logic_vector(to_unsigned(23, 8)) report "TEST FALLITO (WORKING ZONE). Expected 23 found " & integer'image(to_integer(unsigned(RAM(196)))) severity failure;
    assert RAM(197) = std_logic_vector(to_unsigned(243, 8)) report "TEST FALLITO (WORKING ZONE). Expected 243 found " & integer'image(to_integer(unsigned(RAM(197)))) severity failure;
    assert RAM(198) = std_logic_vector(to_unsigned(143, 8)) report "TEST FALLITO (WORKING ZONE). Expected 143 found " & integer'image(to_integer(unsigned(RAM(198)))) severity failure;
    assert RAM(199) = std_logic_vector(to_unsigned(173, 8)) report "TEST FALLITO (WORKING ZONE). Expected 173 found " & integer'image(to_integer(unsigned(RAM(199)))) severity failure;
    assert RAM(200) = std_logic_vector(to_unsigned(16, 8)) report "TEST FALLITO (WORKING ZONE). Expected 16 found " & integer'image(to_integer(unsigned(RAM(200)))) severity failure;
    assert RAM(201) = std_logic_vector(to_unsigned(84, 8)) report "TEST FALLITO (WORKING ZONE). Expected 84 found " & integer'image(to_integer(unsigned(RAM(201)))) severity failure;
    assert RAM(202) = std_logic_vector(to_unsigned(72, 8)) report "TEST FALLITO (WORKING ZONE). Expected 72 found " & integer'image(to_integer(unsigned(RAM(202)))) severity failure;
    assert RAM(203) = std_logic_vector(to_unsigned(189, 8)) report "TEST FALLITO (WORKING ZONE). Expected 189 found " & integer'image(to_integer(unsigned(RAM(203)))) severity failure;
    assert RAM(204) = std_logic_vector(to_unsigned(152, 8)) report "TEST FALLITO (WORKING ZONE). Expected 152 found " & integer'image(to_integer(unsigned(RAM(204)))) severity failure;
    assert RAM(205) = std_logic_vector(to_unsigned(152, 8)) report "TEST FALLITO (WORKING ZONE). Expected 152 found " & integer'image(to_integer(unsigned(RAM(205)))) severity failure;
    assert RAM(206) = std_logic_vector(to_unsigned(212, 8)) report "TEST FALLITO (WORKING ZONE). Expected 212 found " & integer'image(to_integer(unsigned(RAM(206)))) severity failure;
    assert RAM(207) = std_logic_vector(to_unsigned(72, 8)) report "TEST FALLITO (WORKING ZONE). Expected 72 found " & integer'image(to_integer(unsigned(RAM(207)))) severity failure;
    assert RAM(208) = std_logic_vector(to_unsigned(13, 8)) report "TEST FALLITO (WORKING ZONE). Expected 13 found " & integer'image(to_integer(unsigned(RAM(208)))) severity failure;
    assert RAM(209) = std_logic_vector(to_unsigned(70, 8)) report "TEST FALLITO (WORKING ZONE). Expected 70 found " & integer'image(to_integer(unsigned(RAM(209)))) severity failure;
    assert RAM(210) = std_logic_vector(to_unsigned(182, 8)) report "TEST FALLITO (WORKING ZONE). Expected 182 found " & integer'image(to_integer(unsigned(RAM(210)))) severity failure;
    assert RAM(211) = std_logic_vector(to_unsigned(61, 8)) report "TEST FALLITO (WORKING ZONE). Expected 61 found " & integer'image(to_integer(unsigned(RAM(211)))) severity failure;
    assert RAM(212) = std_logic_vector(to_unsigned(216, 8)) report "TEST FALLITO (WORKING ZONE). Expected 216 found " & integer'image(to_integer(unsigned(RAM(212)))) severity failure;
    assert RAM(213) = std_logic_vector(to_unsigned(64, 8)) report "TEST FALLITO (WORKING ZONE). Expected 64 found " & integer'image(to_integer(unsigned(RAM(213)))) severity failure;
    assert RAM(214) = std_logic_vector(to_unsigned(245, 8)) report "TEST FALLITO (WORKING ZONE). Expected 245 found " & integer'image(to_integer(unsigned(RAM(214)))) severity failure;
    assert RAM(215) = std_logic_vector(to_unsigned(139, 8)) report "TEST FALLITO (WORKING ZONE). Expected 139 found " & integer'image(to_integer(unsigned(RAM(215)))) severity failure;
    assert RAM(216) = std_logic_vector(to_unsigned(19, 8)) report "TEST FALLITO (WORKING ZONE). Expected 19 found " & integer'image(to_integer(unsigned(RAM(216)))) severity failure;
    assert RAM(217) = std_logic_vector(to_unsigned(140, 8)) report "TEST FALLITO (WORKING ZONE). Expected 140 found " & integer'image(to_integer(unsigned(RAM(217)))) severity failure;
    assert RAM(218) = std_logic_vector(to_unsigned(61, 8)) report "TEST FALLITO (WORKING ZONE). Expected 61 found " & integer'image(to_integer(unsigned(RAM(218)))) severity failure;
    assert RAM(219) = std_logic_vector(to_unsigned(224, 8)) report "TEST FALLITO (WORKING ZONE). Expected 224 found " & integer'image(to_integer(unsigned(RAM(219)))) severity failure;
    assert RAM(220) = std_logic_vector(to_unsigned(57, 8)) report "TEST FALLITO (WORKING ZONE). Expected 57 found " & integer'image(to_integer(unsigned(RAM(220)))) severity failure;
    assert RAM(221) = std_logic_vector(to_unsigned(123, 8)) report "TEST FALLITO (WORKING ZONE). Expected 123 found " & integer'image(to_integer(unsigned(RAM(221)))) severity failure;
    assert RAM(222) = std_logic_vector(to_unsigned(30, 8)) report "TEST FALLITO (WORKING ZONE). Expected 30 found " & integer'image(to_integer(unsigned(RAM(222)))) severity failure;
    assert RAM(223) = std_logic_vector(to_unsigned(214, 8)) report "TEST FALLITO (WORKING ZONE). Expected 214 found " & integer'image(to_integer(unsigned(RAM(223)))) severity failure;
    assert RAM(224) = std_logic_vector(to_unsigned(159, 8)) report "TEST FALLITO (WORKING ZONE). Expected 159 found " & integer'image(to_integer(unsigned(RAM(224)))) severity failure;
    assert RAM(225) = std_logic_vector(to_unsigned(102, 8)) report "TEST FALLITO (WORKING ZONE). Expected 102 found " & integer'image(to_integer(unsigned(RAM(225)))) severity failure;
    assert RAM(226) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(226)))) severity failure;
    assert RAM(227) = std_logic_vector(to_unsigned(108, 8)) report "TEST FALLITO (WORKING ZONE). Expected 108 found " & integer'image(to_integer(unsigned(RAM(227)))) severity failure;
    assert RAM(228) = std_logic_vector(to_unsigned(220, 8)) report "TEST FALLITO (WORKING ZONE). Expected 220 found " & integer'image(to_integer(unsigned(RAM(228)))) severity failure;
    assert RAM(229) = std_logic_vector(to_unsigned(22, 8)) report "TEST FALLITO (WORKING ZONE). Expected 22 found " & integer'image(to_integer(unsigned(RAM(229)))) severity failure;
    assert RAM(230) = std_logic_vector(to_unsigned(160, 8)) report "TEST FALLITO (WORKING ZONE). Expected 160 found " & integer'image(to_integer(unsigned(RAM(230)))) severity failure;
    assert RAM(231) = std_logic_vector(to_unsigned(198, 8)) report "TEST FALLITO (WORKING ZONE). Expected 198 found " & integer'image(to_integer(unsigned(RAM(231)))) severity failure;
    assert RAM(232) = std_logic_vector(to_unsigned(241, 8)) report "TEST FALLITO (WORKING ZONE). Expected 241 found " & integer'image(to_integer(unsigned(RAM(232)))) severity failure;
    assert RAM(233) = std_logic_vector(to_unsigned(33, 8)) report "TEST FALLITO (WORKING ZONE). Expected 33 found " & integer'image(to_integer(unsigned(RAM(233)))) severity failure;
    assert RAM(234) = std_logic_vector(to_unsigned(109, 8)) report "TEST FALLITO (WORKING ZONE). Expected 109 found " & integer'image(to_integer(unsigned(RAM(234)))) severity failure;
    assert RAM(235) = std_logic_vector(to_unsigned(65, 8)) report "TEST FALLITO (WORKING ZONE). Expected 65 found " & integer'image(to_integer(unsigned(RAM(235)))) severity failure;
    assert RAM(236) = std_logic_vector(to_unsigned(97, 8)) report "TEST FALLITO (WORKING ZONE). Expected 97 found " & integer'image(to_integer(unsigned(RAM(236)))) severity failure;
    assert RAM(237) = std_logic_vector(to_unsigned(225, 8)) report "TEST FALLITO (WORKING ZONE). Expected 225 found " & integer'image(to_integer(unsigned(RAM(237)))) severity failure;
    assert RAM(238) = std_logic_vector(to_unsigned(73, 8)) report "TEST FALLITO (WORKING ZONE). Expected 73 found " & integer'image(to_integer(unsigned(RAM(238)))) severity failure;
    assert RAM(239) = std_logic_vector(to_unsigned(254, 8)) report "TEST FALLITO (WORKING ZONE). Expected 254 found " & integer'image(to_integer(unsigned(RAM(239)))) severity failure;
    assert RAM(240) = std_logic_vector(to_unsigned(5, 8)) report "TEST FALLITO (WORKING ZONE). Expected 5 found " & integer'image(to_integer(unsigned(RAM(240)))) severity failure;
    assert RAM(241) = std_logic_vector(to_unsigned(249, 8)) report "TEST FALLITO (WORKING ZONE). Expected 249 found " & integer'image(to_integer(unsigned(RAM(241)))) severity failure;
    assert RAM(242) = std_logic_vector(to_unsigned(120, 8)) report "TEST FALLITO (WORKING ZONE). Expected 120 found " & integer'image(to_integer(unsigned(RAM(242)))) severity failure;
    assert RAM(243) = std_logic_vector(to_unsigned(95, 8)) report "TEST FALLITO (WORKING ZONE). Expected 95 found " & integer'image(to_integer(unsigned(RAM(243)))) severity failure;
    assert RAM(244) = std_logic_vector(to_unsigned(30, 8)) report "TEST FALLITO (WORKING ZONE). Expected 30 found " & integer'image(to_integer(unsigned(RAM(244)))) severity failure;
    assert RAM(245) = std_logic_vector(to_unsigned(209, 8)) report "TEST FALLITO (WORKING ZONE). Expected 209 found " & integer'image(to_integer(unsigned(RAM(245)))) severity failure;
    assert RAM(246) = std_logic_vector(to_unsigned(19, 8)) report "TEST FALLITO (WORKING ZONE). Expected 19 found " & integer'image(to_integer(unsigned(RAM(246)))) severity failure;
    assert RAM(247) = std_logic_vector(to_unsigned(23, 8)) report "TEST FALLITO (WORKING ZONE). Expected 23 found " & integer'image(to_integer(unsigned(RAM(247)))) severity failure;
    assert RAM(248) = std_logic_vector(to_unsigned(3, 8)) report "TEST FALLITO (WORKING ZONE). Expected 3 found " & integer'image(to_integer(unsigned(RAM(248)))) severity failure;
    assert RAM(249) = std_logic_vector(to_unsigned(59, 8)) report "TEST FALLITO (WORKING ZONE). Expected 59 found " & integer'image(to_integer(unsigned(RAM(249)))) severity failure;
    assert RAM(250) = std_logic_vector(to_unsigned(234, 8)) report "TEST FALLITO (WORKING ZONE). Expected 234 found " & integer'image(to_integer(unsigned(RAM(250)))) severity failure;
    assert RAM(251) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(251)))) severity failure;
    assert RAM(252) = std_logic_vector(to_unsigned(232, 8)) report "TEST FALLITO (WORKING ZONE). Expected 232 found " & integer'image(to_integer(unsigned(RAM(252)))) severity failure;
    assert RAM(253) = std_logic_vector(to_unsigned(41, 8)) report "TEST FALLITO (WORKING ZONE). Expected 41 found " & integer'image(to_integer(unsigned(RAM(253)))) severity failure;
    assert RAM(254) = std_logic_vector(to_unsigned(203, 8)) report "TEST FALLITO (WORKING ZONE). Expected 203 found " & integer'image(to_integer(unsigned(RAM(254)))) severity failure;
    assert RAM(255) = std_logic_vector(to_unsigned(73, 8)) report "TEST FALLITO (WORKING ZONE). Expected 73 found " & integer'image(to_integer(unsigned(RAM(255)))) severity failure;
    assert RAM(256) = std_logic_vector(to_unsigned(252, 8)) report "TEST FALLITO (WORKING ZONE). Expected 252 found " & integer'image(to_integer(unsigned(RAM(256)))) severity failure;
    assert RAM(257) = std_logic_vector(to_unsigned(255, 8)) report "TEST FALLITO (WORKING ZONE). Expected 255 found " & integer'image(to_integer(unsigned(RAM(257)))) severity failure;
    assert RAM(258) = std_logic_vector(to_unsigned(214, 8)) report "TEST FALLITO (WORKING ZONE). Expected 214 found " & integer'image(to_integer(unsigned(RAM(258)))) severity failure;
    assert RAM(259) = std_logic_vector(to_unsigned(29, 8)) report "TEST FALLITO (WORKING ZONE). Expected 29 found " & integer'image(to_integer(unsigned(RAM(259)))) severity failure;
    assert RAM(260) = std_logic_vector(to_unsigned(116, 8)) report "TEST FALLITO (WORKING ZONE). Expected 116 found " & integer'image(to_integer(unsigned(RAM(260)))) severity failure;
    assert RAM(261) = std_logic_vector(to_unsigned(108, 8)) report "TEST FALLITO (WORKING ZONE). Expected 108 found " & integer'image(to_integer(unsigned(RAM(261)))) severity failure;
    assert RAM(262) = std_logic_vector(to_unsigned(1, 8)) report "TEST FALLITO (WORKING ZONE). Expected 1 found " & integer'image(to_integer(unsigned(RAM(262)))) severity failure;
    assert RAM(263) = std_logic_vector(to_unsigned(24, 8)) report "TEST FALLITO (WORKING ZONE). Expected 24 found " & integer'image(to_integer(unsigned(RAM(263)))) severity failure;
    assert RAM(264) = std_logic_vector(to_unsigned(64, 8)) report "TEST FALLITO (WORKING ZONE). Expected 64 found " & integer'image(to_integer(unsigned(RAM(264)))) severity failure;
    assert RAM(265) = std_logic_vector(to_unsigned(38, 8)) report "TEST FALLITO (WORKING ZONE). Expected 38 found " & integer'image(to_integer(unsigned(RAM(265)))) severity failure;
    assert RAM(266) = std_logic_vector(to_unsigned(22, 8)) report "TEST FALLITO (WORKING ZONE). Expected 22 found " & integer'image(to_integer(unsigned(RAM(266)))) severity failure;
    assert RAM(267) = std_logic_vector(to_unsigned(15, 8)) report "TEST FALLITO (WORKING ZONE). Expected 15 found " & integer'image(to_integer(unsigned(RAM(267)))) severity failure;
    assert RAM(268) = std_logic_vector(to_unsigned(134, 8)) report "TEST FALLITO (WORKING ZONE). Expected 134 found " & integer'image(to_integer(unsigned(RAM(268)))) severity failure;
    assert RAM(269) = std_logic_vector(to_unsigned(169, 8)) report "TEST FALLITO (WORKING ZONE). Expected 169 found " & integer'image(to_integer(unsigned(RAM(269)))) severity failure;
    assert RAM(270) = std_logic_vector(to_unsigned(59, 8)) report "TEST FALLITO (WORKING ZONE). Expected 59 found " & integer'image(to_integer(unsigned(RAM(270)))) severity failure;
    assert RAM(271) = std_logic_vector(to_unsigned(168, 8)) report "TEST FALLITO (WORKING ZONE). Expected 168 found " & integer'image(to_integer(unsigned(RAM(271)))) severity failure;

    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end maxconttb;
