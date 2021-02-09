------------------------------------------------
------------------------------------------------
-- Fichier permettant de generer une horloge de 3kHz à partir 
-- de l'horloge 100MHz interne du FPGA  
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CE_affichage is
    port ( H  : IN STD_LOGIC;
           raz  : IN STD_LOGIC;
           CE_affichage   : OUT STD_LOGIC);
end CE_affichage;

architecture Behavioral of CE_affichage is

signal compteur1 : unsigned (15 downto 0) := (OTHERS => '0'); 

begin
    
    PROCESS (H,raz)
        BEGIN
            IF raz = '1' THEN
                CE_affichage <= '0'; 
            
            ELSIF (H'EVENT AND H = '1') THEN
                compteur1 <= compteur1 + 1;               
            
                IF compteur1 = 33333 THEN             
                         CE_affichage <= '1';
                         compteur1 <= (OTHERS => '0');
                      
                ELSE
                       CE_affichage <= '0';                                
                END IF;                        
            END IF;
    END PROCESS; 
end Behavioral;