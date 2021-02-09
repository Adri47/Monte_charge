------------------------------------------------
------------------------------------------------
-- Fichier top permettant d'assembler les fichiers :
--          - module_affichage 
--          - gestion_horloge 
--          - controle_monte_charge 
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity top is
  Port (H, raz : in std_logic;
        --CE_increment : in std_logic; --signal utilisé que pour la simulation afin de réduire le temps de simu
        poussoir_bas, poussoir_haut : in std_logic;
        capteur_haut, capteur_bas : out std_logic; 
        numero_afficheur : out std_logic_vector(3 downto 0);
        valeur_afficheur : out std_logic_vector(6 downto 0)
         );
end top;

architecture Behavioral of top is

    signal clk_inter, rst_inter, CE_affichage_inter, CE_traitement_inter, activation_inter, CE_increment_inter : std_logic ;
    signal p_h_inter, p_b_inter, k_h_inter, k_b_inter : std_logic;
    signal in_bin_inter, cpt_inter: std_logic_vector(4 downto 0);
    signal s_inter, selction_init : std_logic_vector (1 downto 0);

begin

    mod_affichage : entity work.module_affichage 
    port map(CE_affichage => CE_affichage_inter,
             raz => raz,
             valeur => in_bin_inter,
             numero_afficheur => numero_afficheur,
             valeur_afficheur => valeur_afficheur,
             H => h
             );

    gestion_horloge : entity work.gestion_horloge
    port map (H => h,
              raz => raz,
              CE_affichage => CE_affichage_inter,
              CE_increment => activation_inter,
              CE_traitement => CE_traitement_inter
              );
           
    Monte_charge : entity work.controle_monte_charge
    port map(CE_increment => activation_inter, 
             CE_traitement => CE_traitement_inter,
             poussoir_haut => poussoir_haut,
             poussoir_bas => poussoir_bas,
             raz => raz,
             capteur_haut => capteur_haut,
             capteur_bas => capteur_bas,
             valeur => in_bin_inter,
             H => h
             );

end Behavioral;
