----------------------------------------------------------------------------------
-- Company: FH Campus Wien
-- Engineer: FH-Prof. DI Christian Halter
-- 
-- Create Date: 03/31/2022 01:28:06 PM
-- Design Name: Trafic Lifht phases template
-- Module Name: ampel - simple
-- Project Name: Trafic Lifht
-- Target Devices: XC7A100T
-- Tool Versions: Vivado v2020.2
-- Description: A trafic light with a night mode feature (template)
-- 
-- Dependencies: ampel_const.vhd
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.ampel_const.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ampel is
port(
    clk : in STD_LOGIC;
    reset : in STD_LOGIC;
    timer_puls : in STD_LOGIC;
    timer_ack : inout STD_LOGIC;
    lights_X : out STD_LOGIC_VECTOR (2 downto 0);
    lights_Y : out STD_LOGIC_VECTOR (2 downto 0));
end ampel;

architecture simple of ampel is
    signal phase, nextPhase : state;
    signal nextTimer_ack : std_logic;
begin
    syn_phase : process(clk, reset, nextPhase,
        nextTimer_ack)
    begin
        if reset = ACTIVE then
            phase <= Xyel;
            timer_ack <= not ACTIVE;
        else
        if clk'event and clk = '1' then
            phase <= nextPhase;
            timer_ack <= nextTimer_ack;
        end if;
        end if;
    end process syn_phase;

    next_phase : process(timer_puls, phase, timer_ack, nextPhase)
    begin
        nextPhase <= phase;
        nextTimer_ack <= not ACTIVE;
    if timer_puls = ACTIVE then
        nextTimer_ack <= ACTIVE;
        if timer_ack = not ACTIVE then
            case phase is
                when Xyel => nextPhase <= Xred;
                when Xred => nextPhase <= Xry;
                when Xry => nextPhase <= Xgrn;
                when others => nextPhase <= Xyel;
            end case;
        end if;
    end if;
    end process next_phase;
    
    output : process(phase)
    begin
        case phase is
            when Xgrn => lights_X <= GREEN;
                         lights_Y <= RED;
            when Xred => lights_X <= RED;
                         lights_Y <= GREEN;
            when Xry => lights_X <= REDYEL;
                        lights_Y <= YELLOW;
            when others => lights_X <= YELLOW;
                           lights_Y <= REDYEL;
        end case;
    end process output;
end simple;
