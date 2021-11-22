library ieee;
use ieee.std_logic_1164.all;

entity fulladder4 is
  port(
    A, B: in std_logic_vector(3 downto 0);
    CIN: in std_logic;
    S: out std_logic_vector(3 downto 0);
    COUT: out std_logic
  );
end entity;

architecture structural of fulladder4 is

  signal carry: std_logic_vector(2 downto 0);

begin
  s1b: entity work.fulladder1(behavioral)
    port map(A => A(0), B => B(0), CIN => CIN, S => S(0), COUT => carry(0));

  s1b: entity work.fulladder1(behavioral)
    port map(A => A(1), B => B(1), CIN => carry(0), S => S(1), COUT => carry(1));

  s1b: entity work.fulladder1(behavioral)
    port map(A => A(2), B => B(2), CIN => carry(1), S => S(2), COUT => carry(2));

  s1b: entity work.fulladder1(behavioral)
    port map(A => A(3), B => B(3), CIN => carry(2), S => S(3), COUT => COUT);

end architecture;

  --S(0) <= A(0) xor B(0) xor CIN;
  --carry(0) <= (A(0) and B(0)) or (A(0) and CIN or (B(0) and CIN);

  --S(1) <= A(1) xor B(1) xor carry(0);
  --carry(1) <= (A(1) and B(1)) or (A(1) and carry(0)) or (B(1) and carry(0));

  --S(2) <= A(2) xor B(2) xor carry(1);
  --carry(2) <= (A(2) and B(2)) or (A(2) and carry(1)) or (B(2) and carry(1));

  --S(3) <= A(3) xor B(3) xor carry(2);
  --COUT <= (A(3) and B(3)) or (A(3) and carry(2)) or (B(3) and carry(2));

  
