------------------------------------------------
------------------------------------------------
-- Fichier de description de la machine à etat du monte charge 
------------------------------------------------
------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity machine_etat is
    Port ( H, CE_traitement, raz : in STD_LOGIC;
           p_h : in STD_LOGIC;
           p_b : in STD_LOGIC;
           k_h : in STD_LOGIC;
           k_b : in STD_LOGIC;
           s : out STD_LOGIC_VECTOR (1 downto 0);
           capteur_haut : out std_logic;
           capteur_bas : out std_logic
           );
end machine_etat;

architecture Behavioral of machine_etat is

TYPE etat IS (etat_init, etat_a, etat_b, etat_c, etat_d, etat_e, etat_f, etat_g,etat_h, etat_i, etat_j, etat_k, etat_l);  -- Define the states
signal pr_state , nx_state : Etat := Etat_a ;

begin

 maj_etat : process (CE_traitement , raz )
    begin
        if (raz = '1') then 
            pr_state <= Etat_init ;
        elsif rising_edge(CE_traitement) then
                pr_state <= nx_state ;
        end if;
    end process maj_etat ;

 cal_nx_state : process (p_h, p_b, k_h, k_b, pr_state )
    begin
        case pr_state is
            when etat_init =>
                if( (p_h xor p_b) = '1') then 
                    nx_state <= etat_l ;
                else
                    nx_state <= etat_init ;
                end if;
            when etat_a => 
                if( (p_h xor p_b) = '1') then 
                    nx_state <= etat_k ;
                else
                    nx_state <= etat_a ;
                end if;
             when etat_b => 
                if( (p_h xor p_b) = '1') then 
                    nx_state <= etat_j ;
                elsif k_h = '1' then
                    nx_state <= etat_e ;
                else 
                    nx_state <= etat_b ;
                end if;
             when etat_c =>
                if ( p_b and not(p_h) ) = '1' then
                    nx_state <= etat_h ;
                elsif (p_h and not(p_b)) = '1' then
                    nx_state <= etat_i ;
                else
                    nx_state <= etat_c ;
                end if;
             when etat_d =>
                if k_b = '1' then
                    nx_state <= etat_a ;
                elsif ( (p_h xor p_b) = '1') then  
                    nx_state <= etat_g ;
                else
                    nx_state <= etat_d ;
                end if;
              when etat_e =>
                if ( (p_h xor p_b) = '1') then  
                    nx_state <= etat_f ;
                 else
                    nx_state <= etat_e ;
                 end if;
               when etat_f =>
                if ( ( p_h nor p_b) = '1') then
                    nx_state <= etat_d ;
                else 
                    nx_state <= etat_f ;
                end if;
               when etat_g =>
                if ( ( p_h nor p_b) = '1') then
                    nx_state <= etat_c ;
                else 
                    nx_state <= etat_g ;
                end if;
               when etat_h =>
                if (  (p_b nor p_h) = '1') then
                    nx_state <= etat_d ;
                else 
                    nx_state <= etat_h ;
                end if;
               when etat_i =>
                if (  (p_h nor p_b) = '1') then
                    nx_state <= etat_b ;
                else 
                    nx_state <= etat_i ;
                end if;
               when etat_j =>
                if (  (p_h nor p_b) = '1') then
                    nx_state <= etat_c ;
                else 
                    nx_state <= etat_j ;
                end if;
               when etat_k =>
                if (  (p_h nor p_b) = '1') then
                    nx_state <= etat_b ;
                else 
                    nx_state <= etat_k ;
                end if;
              when etat_l =>
                if (  (p_h nor p_b) = '1') then
                    nx_state <= etat_b ;
                else 
                    nx_state <= etat_l ;
                end if;
         end case;
end process cal_nx_state ;

    cal_output : process ( pr_state )
        begin
            case pr_state is
                when etat_init =>
                         s <= "11";
                         capteur_bas <='0';
                         capteur_haut <= '0';
                when etat_a => 
                        s <= "00"; 
                        capteur_bas <= '1';
                when etat_b => 
                        s <= "01"; 
                        capteur_bas <= '0';
                when etat_c => s <= "00"; 
                when etat_d => 
                        s <= "10";
                        capteur_haut <= '0';
                when etat_e => 
                        s <= "00"; 
                        capteur_haut <= '1';
                when etat_f =>s <= "00";
                when etat_g => s <= "10";
                when etat_h => s <= "00";
                when etat_i => s <= "00";    
                when etat_j => s <= "01"; 
                when etat_k => s <= "00";
                when etat_l => s <= "11"; 
            end case;
        end process cal_output ;

end Behavioral;
