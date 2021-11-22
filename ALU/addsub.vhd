library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity addsub is
    generic (
        N: natural := 8
    );
    port (
        A, B: in std_logic_vector(N-1 downto 0);
        operation: in std_logic;
        S: out std_logic_vector(N-1 downto 0)
    );
end entity;

architecture behavioral of addsub is

begin
    process(A, B, operation)
    begin
    if operation = '0' then
        S <= std_logic_vector(unsigned(A) + unsigned(B));
    else
        S <= std_logic_vector(unsigned(A) - unsigned(B));
    end if;

    end process;
end architecture;
