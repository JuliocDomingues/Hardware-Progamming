library ieee;
use ieee.std_logic_1164.all;

entity fulladder1 is
  port(
    A, B, CIN: in std_logic;
    S, COUT: out std_logic
    );
end entity;

architecture behavioral of fulladder1 is
begin
  S <= A xor B xor CIN;
  COUT <= (A and B) or (A and CIN) or (B and CIN);
end architecture;
