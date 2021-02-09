------------------------------------------------
------------------------------------------------
-- Fichier permettant de décoder la valeur à afficher sur le 7 segments 
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity decodeur_sept_segments is
Port ( valeur_entree : in STD_LOGIC_VECTOR (4 downto 0);
       valeur_decodee : out STD_LOGIC_VECTOR(6 downto 0)
      );
end decodeur_sept_segments ;

architecture with_select of decodeur_sept_segments is

begin

    with valeur_entree select
    valeur_decodee <=  "1000000" when "00000" ,-- 0
                       "1111001" when "00001" ,-- 1
                       "0100100" when "00010" ,-- 2
                       "0110000" when "00011" ,-- 3
                       "0011001" when "00100" ,-- 4
                       "0010010" when "00101" ,-- 5
                       "0000010" when "00110" ,-- 6
                       "1111000" when "00111" ,-- 7
                       "0000000" when "01000" ,-- 8
                       "0010000" when "01001" ,-- 9
                       "0000011" when "10000" ,-- b
                       "0001011" when "10001" ,-- h
                       "0111111" when "10011" ,-- - 
                       "1111111" when others ; -- 7 segments éteint
end with_select ;