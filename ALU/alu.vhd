library ieee;
use ieee.std_logic_1164.all;

entity alu is
    generic( 
        N: natural := 8 
    );
    port(
        A, B: in std_logic_vector(N-1 downto 0);
        C: in std_logic_vector(2 downto 0);
        S: out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture structural of alu is
    signal S1, S2: std_logic_vector(N-1 downto 0);

begin

    orand: entity work.andor(behavioral)
    generic map(N)
    port map(A, B, C(1), S1);
    
    subadd: entity work.addsub(behavioral)
    generic map(N)
    port map(A, B, C(2), S2);
    
    s1b: entity work.multiplex2x1(behavioral)
    generic map(N)
    port map(S1, S2, C(0), S);
end architecture;
