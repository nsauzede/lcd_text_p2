library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity lcdctl is
    Port ( clk : in  STD_LOGIC;
			ud : out  STD_LOGIC;
			rl : out  STD_LOGIC;
			enab : out  STD_LOGIC;
			vsync : out  STD_LOGIC;
			hsync : out  STD_LOGIC;
			ck : out  STD_LOGIC;
			r : out std_logic_vector(5 downto 0);
			g : out std_logic_vector(5 downto 0);
			b : out std_logic_vector(5 downto 0)
	);
end lcdctl;
architecture Behavioral of lcdctl is
signal clk_fast : std_logic := '0';
signal ired : std_logic_vector(5 downto 0) := "000000";
signal igreen : std_logic_vector(5 downto 0) := "000000";
signal iblue : std_logic_vector(5 downto 0) := "000000";
constant htotal : integer := 900; -- screen size, with back porch
constant thp : integer := 156; -- hsync
constant hfront : integer := thp + 104; -- front porch + hsync
constant hactive : integer := 640; -- display size
signal hcurrent : integer range 0 to htotal := 0;
constant vtotal : integer := 560; -- screen size, with back porch
constant tvp : integer := 1; -- vsync
constant vfront : integer := 34; -- front porch
constant vactive : integer := 480; -- display size
signal vcurrent : integer range 0 to vtotal := 0;
--subtype t_dim1 is std_logic_vector( downto 0);
--type t_dim1_vector is array(natural range <>) of t_dim1;
--subtype t_dim2 is t_dim1_vector(0 to c1_r2);
--signal font : t_dim2;
--constant fheight : integer := 8; -- font height in pixels
constant fheight : integer := 16; -- font height in pixels
constant fwidth : integer := 8; -- font width in pixels
constant flen : integer := 2; -- font len = how many chars defined in the font
signal font : std_logic_vector(0 to (fheight * fwidth * flen) - 1) :=""
&"00000000"&"00000000"&"00010000"&"00111000"&"01101100"&"11000110"&"11000110"&"11111110"
&"11000110"&"11000110"&"11000110"&"11000110"&"00000000"&"00000000"&"00000000"&"00000000"	--A
&"00000000"&"00000000"&"11111100"&"01100110"&"01100110"&"01100110"&"01111100"&"01100110"
&"01100110"&"01100110"&"01100110"&"11111100"&"00000000"&"00000000"&"00000000"&"00000000";	--B
constant tlen : integer := 2;		-- how many text cells ?
constant tchlen : integer := 8;	-- how many bits per text cell ?
signal text : std_logic_vector(((tchlen * tlen) - 1) downto 0) := x"4142";

begin
	ud <= '1';
	rl <= '1';
	enab <= '0';
	ck <= clk_fast;
	r <= ired;
	g <= igreen;
	b <= iblue;
	process(clk)
	begin
		if rising_edge(clk) then
			clk_fast <= not clk_fast;
		end if;
	end process;
	process(clk_fast)
	begin
		if rising_edge(clk_fast) then
			if hcurrent < thp then
				hsync <= '0';
			else
				hsync <= '1';
			end if;
			if vcurrent < tvp then
				vsync <= '0';
			else
				vsync <= '1';
			end if;
			if hcurrent = htotal then
				hcurrent <= 0;
				if vcurrent = vtotal then
					vcurrent <= 0;
				else
					vcurrent <= vcurrent + 1;
				end if;
			else
				hcurrent <= hcurrent + 1;
			end if;
			ired <= (others => '0');
			igreen <= (others => '0');
			iblue <= (others => '0');

			if (vcurrent >= vfront) and (vcurrent < (vfront + vactive)) then
				if (hcurrent >= hfront) and (hcurrent < (hfront + hactive)) then
					igreen <= (others => '0');
					if font(((((hcurrent-hfront) / fwidth) mod flen)*fheight+(vcurrent-vfront) mod fheight)*fwidth+(hcurrent-hfront)mod fwidth)='1' then
						ired <= (others => '1');
						igreen <= (others => '1');
						iblue <= (others => '1');
					end if;
				end if;
			end if;

		end if;
	end process;
end Behavioral;
