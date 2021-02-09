------------------------------------------------
------------------------------------------------
-- Fichier permettant de décoder le numéro afficheur à sélectionner 
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity decodeur_num_aff is
    Port ( numero_afficheur_entree : in std_logic_vector(2 downto 0);
           numero_afficheur_decodee : out STD_LOGIC_VECTOR(3 downto 0)
          );
end decodeur_num_aff ;

architecture behavioral of decodeur_num_aff is

begin

    with numero_afficheur_entree select
    numero_afficheur_decodee <=  "1110" when "001" ,
                                 "1101" when "010" ,
                                 "1011" when "011" ,
                                 "0111" when "100" ,
                                 "1111" when others ;
    
end behavioral ;