------------------------------------------------
------------------------------------------------
-- Fichier permettant de gérer l'affichage   
------------------------------------------------
------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity afficheur_valeur is
  Port (CE_affichage, raz : in std_logic;
        valeur : in std_logic_vector(4 downto 0);
        numero_afficheur : out std_logic_vector(2 downto 0);
        valeur_afficheur : out std_logic_vector(4 downto 0);
        H : in std_logic
        );
end afficheur_valeur;


architecture Behavioral of afficheur_valeur is

    signal val        : unsigned (4 downto 0) :=  "00000";
    signal unite      : unsigned (4 downto 0) :=  "00000";
    signal dizaine    : unsigned (4 downto 0) :=  "00000";
    signal nb         : unsigned (1 downto 0) :=  "00";
    signal bn         : unsigned (1 downto 0) :=  "00";
    signal tp         : unsigned (1 downto 0) :=  "00";
    signal w          : unsigned (1 downto 0) :=  "00";
    signal z          : unsigned (1 downto 0) :=  "00";
    
begin

    process(H,raz)
                begin
                    if raz = '1' then
                        valeur_afficheur <= "00000";
                        numero_afficheur <= "010";
                     elsif rising_edge(H) then
                        val      <= unsigned (valeur);
                        unite       <= (val) mod 10;
                        dizaine     <= (val/10) mod 10;
                       
                       if (CE_affichage = '1') then
                        case val is 
                            when "00000" =>                             -- si la valeur est 0
                                 if bn = 0 then
                                    valeur_afficheur <= "10011";        -- affichage de '-'
                                    numero_afficheur <= "001";          -- sept segment n°1
                                    bn <= "01"; 
                                 elsif bn = 1 then
                                    valeur_afficheur <= valeur;         --affichage du chiffre 0
                                    numero_afficheur <= "010";          -- sept segments n°2
                                    bn <= "10"; 
                                 elsif bn = 2 then
                                    valeur_afficheur <= "00000";        --affichage du zéro par défauts pour 00
                                    numero_afficheur <= "011";          --sept segments n°3
                                    bn <= "11";
                                 elsif bn = 3 then
                                    valeur_afficheur <= "10000";        -- affichage de 'b'
                                    numero_afficheur <= "100";          -- sept segment n°4
                                    bn <= "00";
                                 end if;
    
                            when "00001" | "00010" | "00011" | "00100" | "00101" | "00110" | "00111" | "01000" | "01001" => -- si la velru est entre 1 et 9 
                                 if z = 0 then
                                        valeur_afficheur <= "10011";    -- affichage de '-' 
                                        numero_afficheur <= "001";      -- sept segment n°1
                                        z <= "01";
                                 elsif z = 1 then
                                        valeur_afficheur <= valeur;     -- affichage de la valeur
                                        numero_afficheur <= "010";      -- sept segment n°2
                                        z <= "10";
                                  elsif z = 2 then
                                        valeur_afficheur <= "00000";    -- affichage de 0 avant la valeur
                                        numero_afficheur <= "011";      -- sept segment n°3
                                        z <= "11";
                                  elsif z = 3 then
                                        valeur_afficheur <= "10011";    -- affichage de '-' 
                                        numero_afficheur <= "100";      -- sept segment n°4
                                        z <= "00";
                                  end if; 
                            
                            when "01010" | "01011" | "01100" | "01101" | "01110" =>    -- si la valeur est entre 10 et 14
                                 if tp = 0 then
                                        valeur_afficheur <= "10011";                   -- affichage de '-' 
                                        numero_afficheur <= "001";                     -- sept segment n°1
                                        tp <= "01";
                                 elsif tp = 1 then
                                        valeur_afficheur <= std_logic_vector(unite);   -- affichage de l'unité
                                        numero_afficheur <= "010";                     -- sept segment n°2
                                        tp <= "10";
                                 elsif tp = 2 then
                                        valeur_afficheur <= std_logic_vector(dizaine); -- affichage de la dizaine soit '1' 
                                        numero_afficheur <= "011";                     -- sept segment n°3
                                        tp <= "11";
                                  elsif tp = 3 then
                                        valeur_afficheur <= "10011";                   -- affichage de '-' 
                                        numero_afficheur <= "100";                     -- sept segment n°4
                                        tp <= "00";
                                 end if;
    
                            when "01111" => valeur_afficheur <= valeur;
                                 if nb = 0 then
                                    valeur_afficheur <= "10001";                 -- affichage de 'h'
                                    numero_afficheur <= "001";                   -- sept segment n°1
                                    nb <= "01";
                                elsif nb = 1 then
                                    valeur_afficheur <= std_logic_vector(unite); --affichage de '5'
                                    numero_afficheur <= "010";                   -- sept segments n°2
                                    nb <= "10";
                                elsif nb = 2 then
                                    valeur_afficheur <= std_logic_vector(dizaine);--affichage de '1'
                                    numero_afficheur <= "011";                    -- sept segments n°3
                                    nb <= "11";
                                elsif nb = 3 then
                                    valeur_afficheur <= "10011";                  -- affichage de '-'
                                    numero_afficheur <= "100";                    -- sept segment n°4
                                    nb <= "00";
                                 end if;
                                 
                            when "10000" =>       -- si la valeur est 16 alors on est à l'etat d'init, on affiche donc '-00-'
                                if w = 0 then
                                    valeur_afficheur <= "10011";    -- affichage de '-'
                                    numero_afficheur <= "001";      -- sept segment n°1
                                    w <= "01"; 
                                 elsif w = 1 then
                                    valeur_afficheur <= "00000";    --affichage du chiffre 0
                                    numero_afficheur <= "010";      -- sept segments n°2
                                    w <= "10"; 
                                 elsif w = 2 then
                                    valeur_afficheur <= "00000";    --affichage du zéro par défauts pour 00
                                    numero_afficheur <= "011";      --sept segments n°3
                                    w <= "11";
                                 elsif w = 3 then
                                    valeur_afficheur <= "10011";    -- affichage de '-'
                                    numero_afficheur <= "100";      -- sept segment n°4
                                    w <= "00";
                                 end if;
                            when others => valeur_afficheur <= "11111"; -- on éteint tout
                         end case;
                       end if;
                    end if;
            end process ;
end Behavioral;
