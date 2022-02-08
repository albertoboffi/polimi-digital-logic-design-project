-------------------------------------------------------------------------------
--
-- Final examination - Digital Logic Design
-- Alberto Boffi - Politecnico di Milano, AY 2020/21
-- TEST MODULE: Min contrast
--
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity mincont_tb is
end mincont_tb;

architecture minconttb of mincont_tb is
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
	(0 => std_logic_vector(to_unsigned(25, 8)),
	1 => std_logic_vector(to_unsigned(8, 8)),
	2 => std_logic_vector(to_unsigned(164, 8)),
	3 => std_logic_vector(to_unsigned(164, 8)),
	4 => std_logic_vector(to_unsigned(164, 8)),
	5 => std_logic_vector(to_unsigned(164, 8)),
	6 => std_logic_vector(to_unsigned(164, 8)),
	7 => std_logic_vector(to_unsigned(164, 8)),
	8 => std_logic_vector(to_unsigned(164, 8)),
	9 => std_logic_vector(to_unsigned(164, 8)),
	10 => std_logic_vector(to_unsigned(164, 8)),
	11 => std_logic_vector(to_unsigned(164, 8)),
	12 => std_logic_vector(to_unsigned(164, 8)),
	13 => std_logic_vector(to_unsigned(164, 8)),
	14 => std_logic_vector(to_unsigned(164, 8)),
	15 => std_logic_vector(to_unsigned(164, 8)),
	16 => std_logic_vector(to_unsigned(164, 8)),
	17 => std_logic_vector(to_unsigned(164, 8)),
	18 => std_logic_vector(to_unsigned(164, 8)),
	19 => std_logic_vector(to_unsigned(164, 8)),
	20 => std_logic_vector(to_unsigned(164, 8)),
	21 => std_logic_vector(to_unsigned(164, 8)),
	22 => std_logic_vector(to_unsigned(164, 8)),
	23 => std_logic_vector(to_unsigned(164, 8)),
	24 => std_logic_vector(to_unsigned(164, 8)),
	25 => std_logic_vector(to_unsigned(164, 8)),
	26 => std_logic_vector(to_unsigned(164, 8)),
	27 => std_logic_vector(to_unsigned(164, 8)),
	28 => std_logic_vector(to_unsigned(164, 8)),
	29 => std_logic_vector(to_unsigned(164, 8)),
	30 => std_logic_vector(to_unsigned(164, 8)),
	31 => std_logic_vector(to_unsigned(164, 8)),
	32 => std_logic_vector(to_unsigned(164, 8)),
	33 => std_logic_vector(to_unsigned(164, 8)),
	34 => std_logic_vector(to_unsigned(164, 8)),
	35 => std_logic_vector(to_unsigned(164, 8)),
	36 => std_logic_vector(to_unsigned(164, 8)),
	37 => std_logic_vector(to_unsigned(164, 8)),
	38 => std_logic_vector(to_unsigned(164, 8)),
	39 => std_logic_vector(to_unsigned(164, 8)),
	40 => std_logic_vector(to_unsigned(164, 8)),
	41 => std_logic_vector(to_unsigned(164, 8)),
	42 => std_logic_vector(to_unsigned(164, 8)),
	43 => std_logic_vector(to_unsigned(164, 8)),
	44 => std_logic_vector(to_unsigned(164, 8)),
	45 => std_logic_vector(to_unsigned(164, 8)),
	46 => std_logic_vector(to_unsigned(164, 8)),
	47 => std_logic_vector(to_unsigned(164, 8)),
	48 => std_logic_vector(to_unsigned(164, 8)),
	49 => std_logic_vector(to_unsigned(164, 8)),
	50 => std_logic_vector(to_unsigned(164, 8)),
	51 => std_logic_vector(to_unsigned(164, 8)),
	52 => std_logic_vector(to_unsigned(164, 8)),
	53 => std_logic_vector(to_unsigned(164, 8)),
	54 => std_logic_vector(to_unsigned(164, 8)),
	55 => std_logic_vector(to_unsigned(164, 8)),
	56 => std_logic_vector(to_unsigned(164, 8)),
	57 => std_logic_vector(to_unsigned(164, 8)),
	58 => std_logic_vector(to_unsigned(164, 8)),
	59 => std_logic_vector(to_unsigned(164, 8)),
	60 => std_logic_vector(to_unsigned(164, 8)),
	61 => std_logic_vector(to_unsigned(164, 8)),
	62 => std_logic_vector(to_unsigned(164, 8)),
	63 => std_logic_vector(to_unsigned(164, 8)),
	64 => std_logic_vector(to_unsigned(164, 8)),
	65 => std_logic_vector(to_unsigned(164, 8)),
	66 => std_logic_vector(to_unsigned(164, 8)),
	67 => std_logic_vector(to_unsigned(164, 8)),
	68 => std_logic_vector(to_unsigned(164, 8)),
	69 => std_logic_vector(to_unsigned(164, 8)),
	70 => std_logic_vector(to_unsigned(164, 8)),
	71 => std_logic_vector(to_unsigned(164, 8)),
	72 => std_logic_vector(to_unsigned(164, 8)),
	73 => std_logic_vector(to_unsigned(164, 8)),
	74 => std_logic_vector(to_unsigned(164, 8)),
	75 => std_logic_vector(to_unsigned(164, 8)),
	76 => std_logic_vector(to_unsigned(164, 8)),
	77 => std_logic_vector(to_unsigned(164, 8)),
	78 => std_logic_vector(to_unsigned(164, 8)),
	79 => std_logic_vector(to_unsigned(164, 8)),
	80 => std_logic_vector(to_unsigned(164, 8)),
	81 => std_logic_vector(to_unsigned(164, 8)),
	82 => std_logic_vector(to_unsigned(164, 8)),
	83 => std_logic_vector(to_unsigned(164, 8)),
	84 => std_logic_vector(to_unsigned(164, 8)),
	85 => std_logic_vector(to_unsigned(164, 8)),
	86 => std_logic_vector(to_unsigned(164, 8)),
	87 => std_logic_vector(to_unsigned(164, 8)),
	88 => std_logic_vector(to_unsigned(164, 8)),
	89 => std_logic_vector(to_unsigned(164, 8)),
	90 => std_logic_vector(to_unsigned(164, 8)),
	91 => std_logic_vector(to_unsigned(164, 8)),
	92 => std_logic_vector(to_unsigned(164, 8)),
	93 => std_logic_vector(to_unsigned(164, 8)),
	94 => std_logic_vector(to_unsigned(164, 8)),
	95 => std_logic_vector(to_unsigned(164, 8)),
	96 => std_logic_vector(to_unsigned(164, 8)),
	97 => std_logic_vector(to_unsigned(164, 8)),
	98 => std_logic_vector(to_unsigned(164, 8)),
	99 => std_logic_vector(to_unsigned(164, 8)),
	100 => std_logic_vector(to_unsigned(164, 8)),
	101 => std_logic_vector(to_unsigned(164, 8)),
	102 => std_logic_vector(to_unsigned(164, 8)),
	103 => std_logic_vector(to_unsigned(164, 8)),
	104 => std_logic_vector(to_unsigned(164, 8)),
	105 => std_logic_vector(to_unsigned(164, 8)),
	106 => std_logic_vector(to_unsigned(164, 8)),
	107 => std_logic_vector(to_unsigned(164, 8)),
	108 => std_logic_vector(to_unsigned(164, 8)),
	109 => std_logic_vector(to_unsigned(164, 8)),
	110 => std_logic_vector(to_unsigned(164, 8)),
	111 => std_logic_vector(to_unsigned(164, 8)),
	112 => std_logic_vector(to_unsigned(164, 8)),
	113 => std_logic_vector(to_unsigned(164, 8)),
	114 => std_logic_vector(to_unsigned(164, 8)),
	115 => std_logic_vector(to_unsigned(164, 8)),
	116 => std_logic_vector(to_unsigned(164, 8)),
	117 => std_logic_vector(to_unsigned(164, 8)),
	118 => std_logic_vector(to_unsigned(164, 8)),
	119 => std_logic_vector(to_unsigned(164, 8)),
	120 => std_logic_vector(to_unsigned(164, 8)),
	121 => std_logic_vector(to_unsigned(164, 8)),
	122 => std_logic_vector(to_unsigned(164, 8)),
	123 => std_logic_vector(to_unsigned(164, 8)),
	124 => std_logic_vector(to_unsigned(164, 8)),
	125 => std_logic_vector(to_unsigned(164, 8)),
	126 => std_logic_vector(to_unsigned(164, 8)),
	127 => std_logic_vector(to_unsigned(164, 8)),
	128 => std_logic_vector(to_unsigned(164, 8)),
	129 => std_logic_vector(to_unsigned(164, 8)),
	130 => std_logic_vector(to_unsigned(164, 8)),
	131 => std_logic_vector(to_unsigned(164, 8)),
	132 => std_logic_vector(to_unsigned(164, 8)),
	133 => std_logic_vector(to_unsigned(164, 8)),
	134 => std_logic_vector(to_unsigned(164, 8)),
	135 => std_logic_vector(to_unsigned(164, 8)),
	136 => std_logic_vector(to_unsigned(164, 8)),
	137 => std_logic_vector(to_unsigned(164, 8)),
	138 => std_logic_vector(to_unsigned(164, 8)),
	139 => std_logic_vector(to_unsigned(164, 8)),
	140 => std_logic_vector(to_unsigned(164, 8)),
	141 => std_logic_vector(to_unsigned(164, 8)),
	142 => std_logic_vector(to_unsigned(164, 8)),
	143 => std_logic_vector(to_unsigned(164, 8)),
	144 => std_logic_vector(to_unsigned(164, 8)),
	145 => std_logic_vector(to_unsigned(164, 8)),
	146 => std_logic_vector(to_unsigned(164, 8)),
	147 => std_logic_vector(to_unsigned(164, 8)),
	148 => std_logic_vector(to_unsigned(164, 8)),
	149 => std_logic_vector(to_unsigned(164, 8)),
	150 => std_logic_vector(to_unsigned(164, 8)),
	151 => std_logic_vector(to_unsigned(164, 8)),
	152 => std_logic_vector(to_unsigned(164, 8)),
	153 => std_logic_vector(to_unsigned(164, 8)),
	154 => std_logic_vector(to_unsigned(164, 8)),
	155 => std_logic_vector(to_unsigned(164, 8)),
	156 => std_logic_vector(to_unsigned(164, 8)),
	157 => std_logic_vector(to_unsigned(164, 8)),
	158 => std_logic_vector(to_unsigned(164, 8)),
	159 => std_logic_vector(to_unsigned(164, 8)),
	160 => std_logic_vector(to_unsigned(164, 8)),
	161 => std_logic_vector(to_unsigned(164, 8)),
	162 => std_logic_vector(to_unsigned(164, 8)),
	163 => std_logic_vector(to_unsigned(164, 8)),
	164 => std_logic_vector(to_unsigned(164, 8)),
	165 => std_logic_vector(to_unsigned(164, 8)),
	166 => std_logic_vector(to_unsigned(164, 8)),
	167 => std_logic_vector(to_unsigned(164, 8)),
	168 => std_logic_vector(to_unsigned(164, 8)),
	169 => std_logic_vector(to_unsigned(164, 8)),
	170 => std_logic_vector(to_unsigned(164, 8)),
	171 => std_logic_vector(to_unsigned(164, 8)),
	172 => std_logic_vector(to_unsigned(164, 8)),
	173 => std_logic_vector(to_unsigned(164, 8)),
	174 => std_logic_vector(to_unsigned(164, 8)),
	175 => std_logic_vector(to_unsigned(164, 8)),
	176 => std_logic_vector(to_unsigned(164, 8)),
	177 => std_logic_vector(to_unsigned(164, 8)),
	178 => std_logic_vector(to_unsigned(164, 8)),
	179 => std_logic_vector(to_unsigned(164, 8)),
	180 => std_logic_vector(to_unsigned(164, 8)),
	181 => std_logic_vector(to_unsigned(164, 8)),
	182 => std_logic_vector(to_unsigned(164, 8)),
	183 => std_logic_vector(to_unsigned(164, 8)),
	184 => std_logic_vector(to_unsigned(164, 8)),
	185 => std_logic_vector(to_unsigned(164, 8)),
	186 => std_logic_vector(to_unsigned(164, 8)),
	187 => std_logic_vector(to_unsigned(164, 8)),
	188 => std_logic_vector(to_unsigned(164, 8)),
	189 => std_logic_vector(to_unsigned(164, 8)),
	190 => std_logic_vector(to_unsigned(164, 8)),
	191 => std_logic_vector(to_unsigned(164, 8)),
	192 => std_logic_vector(to_unsigned(164, 8)),
	193 => std_logic_vector(to_unsigned(164, 8)),
	194 => std_logic_vector(to_unsigned(164, 8)),
	195 => std_logic_vector(to_unsigned(164, 8)),
	196 => std_logic_vector(to_unsigned(164, 8)),
	197 => std_logic_vector(to_unsigned(164, 8)),
	198 => std_logic_vector(to_unsigned(164, 8)),
	199 => std_logic_vector(to_unsigned(164, 8)),
	200 => std_logic_vector(to_unsigned(164, 8)),
	201 => std_logic_vector(to_unsigned(164, 8)),
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

    assert RAM(202) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(202)))) severity failure;
    assert RAM(203) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(203)))) severity failure;
    assert RAM(204) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(204)))) severity failure;
    assert RAM(205) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(205)))) severity failure;
    assert RAM(206) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(206)))) severity failure;
    assert RAM(207) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(207)))) severity failure;
    assert RAM(208) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(208)))) severity failure;
    assert RAM(209) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(209)))) severity failure;
    assert RAM(210) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(210)))) severity failure;
    assert RAM(211) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(211)))) severity failure;
    assert RAM(212) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(212)))) severity failure;
    assert RAM(213) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(213)))) severity failure;
    assert RAM(214) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(214)))) severity failure;
    assert RAM(215) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(215)))) severity failure;
    assert RAM(216) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(216)))) severity failure;
    assert RAM(217) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(217)))) severity failure;
    assert RAM(218) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(218)))) severity failure;
    assert RAM(219) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(219)))) severity failure;
    assert RAM(220) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(220)))) severity failure;
    assert RAM(221) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(221)))) severity failure;
    assert RAM(222) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(222)))) severity failure;
    assert RAM(223) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(223)))) severity failure;
    assert RAM(224) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(224)))) severity failure;
    assert RAM(225) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(225)))) severity failure;
    assert RAM(226) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(226)))) severity failure;
    assert RAM(227) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(227)))) severity failure;
    assert RAM(228) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(228)))) severity failure;
    assert RAM(229) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(229)))) severity failure;
    assert RAM(230) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(230)))) severity failure;
    assert RAM(231) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(231)))) severity failure;
    assert RAM(232) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(232)))) severity failure;
    assert RAM(233) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(233)))) severity failure;
    assert RAM(234) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(234)))) severity failure;
    assert RAM(235) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(235)))) severity failure;
    assert RAM(236) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(236)))) severity failure;
    assert RAM(237) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(237)))) severity failure;
    assert RAM(238) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(238)))) severity failure;
    assert RAM(239) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(239)))) severity failure;
    assert RAM(240) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(240)))) severity failure;
    assert RAM(241) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(241)))) severity failure;
    assert RAM(242) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(242)))) severity failure;
    assert RAM(243) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(243)))) severity failure;
    assert RAM(244) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(244)))) severity failure;
    assert RAM(245) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(245)))) severity failure;
    assert RAM(246) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(246)))) severity failure;
    assert RAM(247) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(247)))) severity failure;
    assert RAM(248) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(248)))) severity failure;
    assert RAM(249) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(249)))) severity failure;
    assert RAM(250) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(250)))) severity failure;
    assert RAM(251) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(251)))) severity failure;
    assert RAM(252) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(252)))) severity failure;
    assert RAM(253) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(253)))) severity failure;
    assert RAM(254) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(254)))) severity failure;
    assert RAM(255) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(255)))) severity failure;
    assert RAM(256) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(256)))) severity failure;
    assert RAM(257) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(257)))) severity failure;
    assert RAM(258) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(258)))) severity failure;
    assert RAM(259) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(259)))) severity failure;
    assert RAM(260) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(260)))) severity failure;
    assert RAM(261) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(261)))) severity failure;
    assert RAM(262) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(262)))) severity failure;
    assert RAM(263) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(263)))) severity failure;
    assert RAM(264) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(264)))) severity failure;
    assert RAM(265) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(265)))) severity failure;
    assert RAM(266) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(266)))) severity failure;
    assert RAM(267) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(267)))) severity failure;
    assert RAM(268) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(268)))) severity failure;
    assert RAM(269) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(269)))) severity failure;
    assert RAM(270) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(270)))) severity failure;
    assert RAM(271) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(271)))) severity failure;
    assert RAM(272) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(272)))) severity failure;
    assert RAM(273) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(273)))) severity failure;
    assert RAM(274) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(274)))) severity failure;
    assert RAM(275) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(275)))) severity failure;
    assert RAM(276) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(276)))) severity failure;
    assert RAM(277) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(277)))) severity failure;
    assert RAM(278) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(278)))) severity failure;
    assert RAM(279) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(279)))) severity failure;
    assert RAM(280) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(280)))) severity failure;
    assert RAM(281) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(281)))) severity failure;
    assert RAM(282) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(282)))) severity failure;
    assert RAM(283) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(283)))) severity failure;
    assert RAM(284) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(284)))) severity failure;
    assert RAM(285) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(285)))) severity failure;
    assert RAM(286) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(286)))) severity failure;
    assert RAM(287) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(287)))) severity failure;
    assert RAM(288) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(288)))) severity failure;
    assert RAM(289) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(289)))) severity failure;
    assert RAM(290) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(290)))) severity failure;
    assert RAM(291) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(291)))) severity failure;
    assert RAM(292) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(292)))) severity failure;
    assert RAM(293) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(293)))) severity failure;
    assert RAM(294) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(294)))) severity failure;
    assert RAM(295) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(295)))) severity failure;
    assert RAM(296) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(296)))) severity failure;
    assert RAM(297) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(297)))) severity failure;
    assert RAM(298) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(298)))) severity failure;
    assert RAM(299) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(299)))) severity failure;
    assert RAM(300) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(300)))) severity failure;
    assert RAM(301) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(301)))) severity failure;
    assert RAM(302) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(302)))) severity failure;
    assert RAM(303) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(303)))) severity failure;
    assert RAM(304) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(304)))) severity failure;
    assert RAM(305) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(305)))) severity failure;
    assert RAM(306) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(306)))) severity failure;
    assert RAM(307) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(307)))) severity failure;
    assert RAM(308) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(308)))) severity failure;
    assert RAM(309) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(309)))) severity failure;
    assert RAM(310) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(310)))) severity failure;
    assert RAM(311) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(311)))) severity failure;
    assert RAM(312) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(312)))) severity failure;
    assert RAM(313) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(313)))) severity failure;
    assert RAM(314) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(314)))) severity failure;
    assert RAM(315) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(315)))) severity failure;
    assert RAM(316) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(316)))) severity failure;
    assert RAM(317) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(317)))) severity failure;
    assert RAM(318) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(318)))) severity failure;
    assert RAM(319) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(319)))) severity failure;
    assert RAM(320) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(320)))) severity failure;
    assert RAM(321) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(321)))) severity failure;
    assert RAM(322) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(322)))) severity failure;
    assert RAM(323) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(323)))) severity failure;
    assert RAM(324) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(324)))) severity failure;
    assert RAM(325) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(325)))) severity failure;
    assert RAM(326) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(326)))) severity failure;
    assert RAM(327) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(327)))) severity failure;
    assert RAM(328) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(328)))) severity failure;
    assert RAM(329) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(329)))) severity failure;
    assert RAM(330) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(330)))) severity failure;
    assert RAM(331) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(331)))) severity failure;
    assert RAM(332) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(332)))) severity failure;
    assert RAM(333) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(333)))) severity failure;
    assert RAM(334) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(334)))) severity failure;
    assert RAM(335) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(335)))) severity failure;
    assert RAM(336) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(336)))) severity failure;
    assert RAM(337) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(337)))) severity failure;
    assert RAM(338) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(338)))) severity failure;
    assert RAM(339) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(339)))) severity failure;
    assert RAM(340) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(340)))) severity failure;
    assert RAM(341) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(341)))) severity failure;
    assert RAM(342) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(342)))) severity failure;
    assert RAM(343) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(343)))) severity failure;
    assert RAM(344) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(344)))) severity failure;
    assert RAM(345) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(345)))) severity failure;
    assert RAM(346) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(346)))) severity failure;
    assert RAM(347) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(347)))) severity failure;
    assert RAM(348) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(348)))) severity failure;
    assert RAM(349) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(349)))) severity failure;
    assert RAM(350) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(350)))) severity failure;
    assert RAM(351) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(351)))) severity failure;
    assert RAM(352) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(352)))) severity failure;
    assert RAM(353) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(353)))) severity failure;
    assert RAM(354) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(354)))) severity failure;
    assert RAM(355) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(355)))) severity failure;
    assert RAM(356) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(356)))) severity failure;
    assert RAM(357) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(357)))) severity failure;
    assert RAM(358) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(358)))) severity failure;
    assert RAM(359) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(359)))) severity failure;
    assert RAM(360) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(360)))) severity failure;
    assert RAM(361) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(361)))) severity failure;
    assert RAM(362) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(362)))) severity failure;
    assert RAM(363) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(363)))) severity failure;
    assert RAM(364) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(364)))) severity failure;
    assert RAM(365) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(365)))) severity failure;
    assert RAM(366) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(366)))) severity failure;
    assert RAM(367) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(367)))) severity failure;
    assert RAM(368) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(368)))) severity failure;
    assert RAM(369) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(369)))) severity failure;
    assert RAM(370) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(370)))) severity failure;
    assert RAM(371) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(371)))) severity failure;
    assert RAM(372) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(372)))) severity failure;
    assert RAM(373) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(373)))) severity failure;
    assert RAM(374) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(374)))) severity failure;
    assert RAM(375) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(375)))) severity failure;
    assert RAM(376) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(376)))) severity failure;
    assert RAM(377) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(377)))) severity failure;
    assert RAM(378) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(378)))) severity failure;
    assert RAM(379) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(379)))) severity failure;
    assert RAM(380) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(380)))) severity failure;
    assert RAM(381) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(381)))) severity failure;
    assert RAM(382) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(382)))) severity failure;
    assert RAM(383) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(383)))) severity failure;
    assert RAM(384) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(384)))) severity failure;
    assert RAM(385) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(385)))) severity failure;
    assert RAM(386) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(386)))) severity failure;
    assert RAM(387) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(387)))) severity failure;
    assert RAM(388) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(388)))) severity failure;
    assert RAM(389) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(389)))) severity failure;
    assert RAM(390) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(390)))) severity failure;
    assert RAM(391) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(391)))) severity failure;
    assert RAM(392) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(392)))) severity failure;
    assert RAM(393) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(393)))) severity failure;
    assert RAM(394) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(394)))) severity failure;
    assert RAM(395) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(395)))) severity failure;
    assert RAM(396) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(396)))) severity failure;
    assert RAM(397) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(397)))) severity failure;
    assert RAM(398) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(398)))) severity failure;
    assert RAM(399) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(399)))) severity failure;
    assert RAM(400) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(400)))) severity failure;
    assert RAM(401) = std_logic_vector(to_unsigned(0, 8)) report "TEST FALLITO (WORKING ZONE). Expected 0 found " & integer'image(to_integer(unsigned(RAM(401)))) severity failure;

    assert false report "Simulation Ended! TEST PASSATO" severity failure;
end process test;

end minconttb;
