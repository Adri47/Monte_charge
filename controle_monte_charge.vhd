------------------------------------------------
------------------------------------------------
-- Fichier permettant d'assembler les fichiers :
--          - compteur 
--          - machine_etat 
--          - initialisation 
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity controle_monte_charge is
  Port (CE_increment, CE_traitement, poussoir_haut, poussoir_bas, raz, H : in std_logic ;
        capteur_haut, capteur_bas : out std_logic;
        valeur : out std_logic_vector (4 downto 0)
        );
end controle_monte_charge;

architecture Behavioral of controle_monte_charge is

    signal CE_increment_temp, CE_traitement_temp, poussoir_haut_temp, poussoir_bas_temp, en_haut_temp, en_bas_temp  : std_logic ;
    signal valeur_temp : std_logic_vector(4 downto 0);
    signal s : std_logic_vector (1 downto 0);
    
begin

    Compteur : entity work.compteur
    port map (CE_increment => CE_increment,
              H => H,
              raz => raz,
              sens => s,
              en_haut => en_haut_temp,
              en_bas => en_bas_temp,
              valeur => valeur_temp
              );
    
    MAE : entity work.machine_etat
    port map (CE_traitement => CE_traitement,
              H => H,
              raz => raz,
              p_h => poussoir_haut,
              p_b => poussoir_bas,
              k_h => en_haut_temp,
              k_b =>en_bas_temp,
              s => s,
              capteur_haut => capteur_haut,
              capteur_bas => capteur_bas
              );
              
    Init : entity work.initialisation
    port map (compteur => valeur_temp,
               selection => s,
               valeur => valeur
              );
          
end Behavioral;
