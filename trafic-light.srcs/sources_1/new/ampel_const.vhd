library IEEE;
use IEEE.std_logic_1164.all;

package ampel_const is
type state is (Xgrn , Xyel , Xred , Xry);
    constant GREEN :  std_logic_vector (2 downto 0):= "100";
    constant YELLOW : std_logic_vector (2 downto 0):= "010";
    constant RED :    std_logic_vector (2 downto 0):= "001";
    constant REDYEL : std_logic_vector (2 downto 0):= "011";
    constant ACTIVE : std_logic:= '1';
end ampel_const;
