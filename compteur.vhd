------------------------------------------------
------------------------------------------------
-- Fichier permettant de compter de 0 à 15. On peut incrementer ou decrementer suivant
-- le sens donne en entree. 
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity compteur is
  Port ( H, CE_increment, raz : in std_logic;
         sens : in std_logic_vector (1 downto 0);
         en_haut, en_bas : out std_logic;
         valeur : out std_logic_vector (4 downto 0)
         );
end compteur;

architecture Behavioral of compteur is

    signal compteur  : unsigned (4 downto 0);

begin

    process (CE_increment, raz)
   
        begin
        
            if raz = '1' then
                compteur <= "00000";
                en_haut <= '0';
                en_bas <= '1';
                
            elsif rising_edge(CE_increment) then
                case sens is
                when  "01" =>
                    if compteur = 15 then
                        compteur <= compteur;
                        else
                        compteur <= compteur + 1;
                    end if;
                 
                 when  "10" => 
                    if compteur = 0 then
                        compteur <= compteur;
                        else
                        compteur <= compteur - 1;
                    end if;
                    
                  when  others => 
                        compteur <= compteur;
                  
                  end case;
            end if;
            
            if compteur = 15 then
                en_haut <= '1';
                else en_haut <= '0';
            end if;
            
            if compteur = 0 then
                en_bas <= '1';
                else en_bas <= '0';
            end if;  
                 valeur <= std_logic_vector(compteur);
        end process;
end Behavioral;
