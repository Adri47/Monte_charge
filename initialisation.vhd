------------------------------------------------
------------------------------------------------
-- Fichier permettant de mettre à l'etat d'initialisation la machine à etat 
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity initialisation is
    Port ( compteur : in STD_LOGIC_VECTOR (4 downto 0);
           selection : in STD_LOGIC_VECTOR (1 downto 0);
           valeur : out STD_LOGIC_VECTOR (4 downto 0)
          );
end initialisation;

architecture Behavioral of initialisation is

signal test : std_logic;

begin

init : process (selection, compteur, test)

    begin
        case selection is 
            when "11" => 
                        valeur <= "10000" ;
                        test <= '1';
            when others => 
                        if ( (compteur = "00000") and (test = '1') ) then
                            valeur <= "10000";
                        else 
                            valeur <= compteur;
                            test <= '0';
                        end if;
        end case;
    end process init;
end Behavioral;
