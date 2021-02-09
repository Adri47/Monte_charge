------------------------------------------------
------------------------------------------------
-- Fichier permettant de generer une horloge de 25MHz à partir 
-- de l'horloge 100MHz interne du FPGA  
------------------------------------------------
------------------------------------------------

Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity CE_traitement is
  Port ( H, raz : in std_logic;
         CE_traitement : out std_logic
         );
          
end CE_traitement;

architecture Behavioral of CE_traitement is

    signal compteur3 : unsigned(2 downto 0):= (OTHERS => '0');

begin
    
    PROCESS (H,raz)
        BEGIN
            IF raz = '1' THEN
                CE_traitement <= '0'; 
            
            ELSIF (H'EVENT AND H = '1') THEN
                compteur3 <= compteur3 + 1;               
            
                IF compteur3 = 4 THEN             
                         CE_traitement <= '1';
                         compteur3 <= (OTHERS => '0');
                      
                ELSE
                       CE_traitement <= '0';                                
                END IF;                        
            END IF;
    END PROCESS; 
end Behavioral;