Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity gestion_horloge is
  Port ( H, raz : in std_logic;
         CE_affichage : out std_logic;
         CE_traitement : out std_logic;
         CE_increment : out std_logic
         );
          
end gestion_horloge;


architecture Behavioral of gestion_horloge is

begin

affichage : entity work.CE_affichage
port map (H => H,
          raz => raz,
          CE_affichage => CE_affichage
          );
increment : entity work.CE_increment
port map (H => H,
          raz => raz,
          CE_increment => CE_increment
          );

traitement : entity work.CE_traitement
port map (H => H,
          raz => raz,
          CE_traitement => CE_traitement
          );

end Behavioral;