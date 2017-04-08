----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:45:19 12/19/2010 
-- Design Name: 
-- Module Name:    aaatop - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Aaatop is
Port (
	CLK : in  STD_LOGIC;
	txd : inout std_logic;
	rxd : in std_logic;
	
	ARD_RESET : out  STD_LOGIC;
	DUO_SW1 : in  STD_LOGIC;
--	DUO_LED : out std_logic;
			 
	sram_addr : out std_logic_vector(20 downto 0);
	sram_data : inout std_logic_vector(7 downto 0);
	sram_ce : out std_logic;
	sram_we : out std_logic;
	sram_oe : out std_logic;
	
	W1A : inout  STD_LOGIC_VECTOR (7 downto 0);
	W2C : inout  STD_LOGIC_VECTOR (15 downto 0);
	W2D : inout  STD_LOGIC_VECTOR (15 downto 0);
	
--	Arduino : inout  STD_LOGIC_VECTOR (53 downto 0)
	Arduino : inout  STD_LOGIC_VECTOR (21 downto 0)
);
end Aaatop;

architecture Behavioral of aaatop is
signal buttons : std_logic_vector(5 downto 0);
signal audio_left : STD_LOGIC;
signal audio_right : STD_LOGIC;
signal ud : STD_LOGIC;
signal rl : STD_LOGIC;
signal enab : STD_LOGIC;
signal vsync : STD_LOGIC;
signal hsync : STD_LOGIC;
signal ck : STD_LOGIC;
signal r : std_logic_vector(5 downto 0);
signal g : std_logic_vector(5 downto 0);
signal b : std_logic_vector(5 downto 0);

begin
	ARD_RESET <= not(DUO_SW1);
	sram_addr <= (others => '0');
	sram_ce <= '0';
	sram_we <= '0';
	sram_oe <= '0';

	winglcd0 : entity work.winglcdsndbut Port map(
			W1A => w2c,
         W1B => w2d,
			buttons => buttons,
			audio_left => audio_left,
         audio_right => audio_right,
			ud => ud,
			rl => rl,
			enab => enab,
			vsync => vsync,
			hsync => hsync,
			ck => ck,
			r => r,
			g => g,
			b => b
		);
	w1a(0) <= vsync;
	w1a(5) <= hsync;
	w1a(7) <= r(0);
	lcdctl0 : entity work.lcdctl Port map(
			clk => clk,
			ud => ud,
			rl => rl,
			enab => enab,
			vsync => vsync,
			hsync => hsync,
			ck => ck,
			r => r,
			g => g,
			b => b
	);

end Behavioral;

