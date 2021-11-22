library ieee;
use ieee.std_logic_1164.all;

entity tb_fulladder1 is
end;

architecture behavioral of tb_fulladder1 is
  signal a, b, cin, sum, cout: std_logic;
begin
  
  s1b: entity work.fulladder1(behavioral)
    port map(a, b, cin, sum, cout);
  
  estimulo_checagem: process is
    
    type reg_somador is record
      a, b, cin, sum, cout: std_logic;
    end record;

    type vet_somador is array(0 to 7) of reg_somador;
    constant tabela_verdade: vet_somador :=
    --   a    b   cin  sum  cout
      (('0', '0', '0', '0', '0'),
       ('0', '0', '1', '1', '0'),
       ('0', '1', '0', '1', '0'),
       ('0', '1', '1', '0', '1'),
       ('1', '0', '0', '1', '0'),
       ('1', '0', '1', '0', '1'),
       ('1', '1', '0', '0', '1'),
       ('1', '1', '1', '1', '1'));
  begin

    for i in tabela_verdade 'range loop
      a    <= tabela_verdade(i).a;
      b    <= tabela_verdade(i).b;
      cin  <= tabela_verdade(i).cin;

      wait for 1 ns;

      assert sum = tabela_verdade(i).sum report "Erro";
      assert cout = tabela_verdade(i).cout report "Erro";
      
    end loop;
     report "Fim dos testes";
     wait;
  end process estimulo_checagem;
end;
