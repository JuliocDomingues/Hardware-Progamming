library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity washcontrol is
    port (
        inicia, cheia, tempo, vazia: in std_logic;
        clock: in std_logic;   

        entrada_agua: out std_logic :='0';
        aciona_motor: out std_logic :='0';
        saida_agua: out std_logic :='0'
    );
end entity;

architecture behavioral of washcontrol is

type wash_state is (A,B,C,D,E);
signal current_state, next_state : wash_state := A;
begin

    process
    begin
        wait until clock = '1';
        current_state <= next_state;
    end process;


    process(current_state,tempo,inicia,cheia,vazia)
    begin
        case current_state is
            when A => --Máquina Ociosa
                if inicia = '0' then
                    next_state <= A;
                else
                    next_state <= B;
                end if;
            when B => --Máquina enchendo
                if cheia = '0' then
                    next_state <= B;
                else
                    next_state <= C;
                end if;
            when C => --Máquina cheia
                if tempo = '0' then
                    next_state <= C;
                else
                    next_state <= D;
                end if;
            when D => --Máquina esvaziando
                if vazia = '0' then
                    next_state <= D;
                else
                    next_state <= E;
                end if;
            when E => --Máquina vazia
                if vazia = '1' then
                    next_state <= E;
                end if;
        end case;
    end process;


    process(current_state)
    begin
        if current_state = B then
            entrada_agua <= '1';
            aciona_motor <= '0';
            saida_agua <= '0';
        elsif current_state = C then
            entrada_agua <= '0';
            aciona_motor <= '1';
            saida_agua <= '0';
        elsif current_state = D then
            entrada_agua <= '0';
            aciona_motor <= '0';
            saida_agua <= '1';
        elsif current_state = E then
            entrada_agua <= '0';
            aciona_motor <= '0';
            saida_agua <= '0';
        end if;       
    end process;

end architecture;