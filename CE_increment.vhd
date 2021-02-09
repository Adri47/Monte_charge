------------------------------------------------
------------------------------------------------
-- Fichier permettant de generer une horloge de 1Hz à partir 
-- de l'horloge 100MHz interne du FPGA  
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CE_increment is
    port ( H  : IN STD_LOGIC;
           raz  : IN STD_LOGIC;
           CE_increment   : OUT STD_LOGIC);
end CE_increment;

architecture Behavioral of CE_increment is

signal compteur2 : unsigned (26 downto 0) := (OTHERS => '0');  

begin
    
    PROCESS (H,raz)
        BEGIN
            IF raz = '1' THEN
                CE_increment <= '0'; 
            
            ELSIF (H'EVENT AND H = '1') THEN
                compteur2 <= compteur2 + 1;               
            
                IF compteur2 = 100000000 THEN             
                         CE_increment <= '1';
                         compteur2 <= (OTHERS => '0');
                      
                ELSE
                       CE_increment <= '0';                                
                END IF;                        
            END IF;
    END PROCESS; 
end Behavioral;