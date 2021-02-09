------------------------------------------------
------------------------------------------------
-- Fichier permettant d'assembler les fichiers :
--          - afficheur_valeur 
--          - decodeur_num 
--          - decodeur_sept_segments 
------------------------------------------------
------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;


entity module_affichage is
  Port (H, CE_affichage, raz : in std_logic;
        valeur : in std_logic_vector(4 downto 0);
        numero_afficheur : out std_logic_vector(3 downto 0);
        valeur_afficheur : out std_logic_vector(6 downto 0)
         );
end module_affichage;


architecture Behavioral of module_affichage is

    signal numero_afficheur_inter : std_logic_vector(2 downto 0);
    signal valeur_afficheur_inter : std_logic_vector(4 downto 0);
    signal numero_afficheur_decodee : STD_LOGIC_VECTOR(3 downto 0);
    signal valeur_entree_inter : STD_LOGIC_VECTOR (4 downto 0);
    signal valeur_decodee_inter : STD_LOGIC_VECTOR(6 downto 0);

begin

    affichage : entity work.afficheur_valeur
    port map(CE_affichage => CE_affichage,
            raz => raz,
            valeur => valeur,
            numero_afficheur => numero_afficheur_inter,
            valeur_afficheur => valeur_afficheur_inter,
            H => H
            );

    decodeur_numero_afficheur : entity work.decodeur_num_aff
    port map (numero_afficheur_entree => numero_afficheur_inter,
              numero_afficheur_decodee => numero_afficheur
              );

    decodeur_valeur_afficheur : entity work.decodeur_sept_segments
    port map (valeur_entree => valeur_afficheur_inter,
              valeur_decodee => valeur_afficheur
              );
end Behavioral;
