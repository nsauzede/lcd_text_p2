--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:25:20 04/02/2017
-- Design Name:   
-- Module Name:   C:/Users/user/Documents/fpga/lcd_text_p2/tb_top.vhd
-- Project Name:  lcd_text_p2
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Aaatop
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tb_top IS
END tb_top;
 
ARCHITECTURE behavior OF tb_top IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Aaatop
    PORT(
         CLK : IN  std_logic;
         txd : INOUT  std_logic;
         rxd : IN  std_logic;
         ARD_RESET : OUT  std_logic;
         DUO_SW1 : IN  std_logic;
         sram_addr : OUT  std_logic_vector(20 downto 0);
         sram_data : INOUT  std_logic_vector(7 downto 0);
         sram_ce : OUT  std_logic;
         sram_we : OUT  std_logic;
         sram_oe : OUT  std_logic;
         W2C : INOUT  std_logic_vector(15 downto 0);
         W2D : INOUT  std_logic_vector(15 downto 0);
         Arduino : INOUT  std_logic_vector(21 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLK : std_logic := '0';
   signal rxd : std_logic := '0';
   signal DUO_SW1 : std_logic := '0';

	--BiDirs
   signal txd : std_logic;
   signal sram_data : std_logic_vector(7 downto 0);
   signal W2C : std_logic_vector(15 downto 0);
   signal W2D : std_logic_vector(15 downto 0);
   signal Arduino : std_logic_vector(21 downto 0);

 	--Outputs
   signal ARD_RESET : std_logic;
   signal sram_addr : std_logic_vector(20 downto 0);
   signal sram_ce : std_logic;
   signal sram_we : std_logic;
   signal sram_oe : std_logic;

   -- Clock period definitions
   constant CLK_period : time := 31.25 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Aaatop PORT MAP (
          CLK => CLK,
          txd => txd,
          rxd => rxd,
          ARD_RESET => ARD_RESET,
          DUO_SW1 => DUO_SW1,
          sram_addr => sram_addr,
          sram_data => sram_data,
          sram_ce => sram_ce,
          sram_we => sram_we,
          sram_oe => sram_oe,
          W2C => W2C,
          W2D => W2D,
          Arduino => Arduino
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for CLK_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
