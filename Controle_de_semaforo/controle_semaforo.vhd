library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity controle_semaforo is
    port (
        clock: in std_logic;
        alert: in std_logic;
        ledr: out std_logic_vector(17 downto 0);
        ledg: out std_logic_vector(17 downto 0)
    );
end entity;

architecture behavioral of controle_semaforo is

signal delay_RG, delay_RY, delay_GR, delay_YR: std_logic:='0';

type RYG_States is (RG, RY, GR, YR, YY);
signal current_state, next_state: RYG_States;

begin

    process(clock, alert)
    begin
        if alert = '1' then
            current_state <= YY;
        elsif rising_edge(clock) then
            current_state <= next_state;
        end if;
    end process;

    process(delay_RG, delay_RY, delay_GR, delay_YR, current_state)
    begin
        case current_state is
            when RG =>
                ledr(0) <= '1'; --Luz vermelha do primeiro semaforo acessa
                ledg(0) <= '0'; --Luz verde do primeiro semaforo apagada
                ledr(1) <= '0'; --Luz vermelha do segundo semaforo apagada
                ledg(1) <= '1'; --Luz verde do segundo semaforo acessa
                
                if delay_RG = '1' then
                    next_state <= RG;
                else
                    next_state <= RY;
                end if;

            when RY =>    
                ledr(0) <= '1'; --Luz vermelha do primeiro semaforo acessa
                ledg(0) <= '0'; --Luz verde do primeiro semaforo apagada
                ledr(1) <= '1'; --Luz vermelha do segundo semaforo acessa
                ledg(1) <= '1'; --Luz verde do segundo semaforo acessa
                
                if delay_RY = '1' then
                    next_state <= RY;
                else
                    next_state <= GR;
                end if ;

            when GR =>    
                ledr(0) <= '0'; --Luz vermelha do primeiro semaforo apagada
                ledg(0) <= '1'; --Luz verde do primeiro semaforo acessa
                ledr(1) <= '1'; --Luz vermelha do segundo semaforo acessa
                ledg(1) <= '0'; --Luz verde do segundo semaforo apagada
                
                if delay_GR = '1' then
                    next_state <= GR;
                else
                    next_state <= YR;
                end if ;

            when YR =>    
                ledr(0) <= '1'; --Luz vermelha do primeiro semaforo acessa
                ledg(0) <= '1'; --Luz verde do primeiro semaforo acessa
                ledr(1) <= '1'; --Luz vermelha do segundo semaforo acessa
                ledg(1) <= '0'; --Luz verde do segundo semaforo apagada

                if delay_YR = '1' then
                    next_state <= YR;
                else
                    next_state <= RG;
                end if ;

            when YY =>    
                ledr(0) <= '1'; --Luz vermelha do primeiro semaforo acessa
                ledg(0) <= '1'; --Luz verde do primeiro semaforo acessa
                ledr(1) <= '1'; --Luz vermelha do segundo semaforo acessa
                ledg(1) <= '1'; --Luz verde do segundo semaforo acessa
                
                if alert = '0' then
                    next_state <= RG;
                else
                    next_state <= YY;
                end if ;
                
        end case;
    end process;

    process(clock)
    variable count : natural := 0;
    begin
        if rising_edge(clock) then
            count := count + 1;
            if delay_RG = '1' then

                if count < 2500 then
                    delay_RG <= '1';
                    delay_RY <= '0';
                    delay_GR <= '0';
                    delay_YR <= '0';
                else
                    count := 0;
                    delay_RG <= '0';
                    delay_RY <= '1';
                    delay_GR <= '0';
                    delay_YR <= '0';
                end if ;

            elsif delay_RY = '1' then

                if count < 1500 then
                    delay_RG <= '0';
                    delay_RY <= '1';
                    delay_GR <= '0';
                    delay_YR <= '0';
                else
                    count := 0;
                    delay_RG <= '0';
                    delay_RY <= '0';
                    delay_GR <= '1';
                    delay_YR <= '0';
                end if ;

            elsif delay_GR = '1' then

                if count < 3000 then
                    delay_RG <= '0';
                    delay_RY <= '0';
                    delay_GR <= '1';
                    delay_YR <= '0';
                else
                    count := 0;
                    delay_RG <= '0';
                    delay_RY <= '0';
                    delay_GR <= '0';
                    delay_YR <= '1';
                end if ;

            elsif delay_YR = '1' then

                if count < 1500 then
                    delay_RG <= '0';
                    delay_RY <= '0';
                    delay_GR <= '0';
                    delay_YR <= '1';
                else
                    count := 0;
                    delay_RG <= '1';
                    delay_RY <= '0';
                    delay_GR <= '0';
                    delay_YR <= '0';
                end if ;

            else
                delay_GR <= '0';
                delay_RY <= '0';
                delay_GR <= '0';
                delay_YR <= '0';
                count := 0;
            end if;

        end if ;
    end process;
end architecture;
