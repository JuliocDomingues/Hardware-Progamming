library ieee;
library STD; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use STD.textio.all; 
use IEEE.std_logic_textio.all;   

entity tb_addsub is
end;

architecture behavioral of tb_addsub is
  signal a, b, sum: std_logic_vector(7 downto 0):= (others => '0');
  signal operation: std_logic :='0';
begin
  
  s1b: entity work.addsub(behavioral)
    port map(a, b, operation, sum);
  
  estimulo_checagem: process is
    variable my_line : line;
    type reg_somador is record
      a, b: std_logic_vector(7 downto 0);
  		operation: std_logic;
  		sum: std_logic_vector(7 downto 0);
    end record;

    type vet_somador is array(0 to 7) of reg_somador;
    constant tabela_verdade: vet_somador :=
    --      a           b        op    sum/sub
      (("00000000", "00000000", '0', "00000000"),
       ("00000011", "00010010", '0', "00010101"),
       ("01000011", "01010010", '0', "10010101"),
       ("01011001", "01000110", '0', "10011111"),
       ("00000000", "00000000", '1', "00000000"),
       ("00010010", "00000011", '1', "00001111"),
       ("01010010", "01000011", '1', "00001111"),
       ("01011001", "01000110", '1', "00010011"));
  begin

    for i in tabela_verdade 'range loop
      a         <= tabela_verdade(i).a;
      b         <= tabela_verdade(i).b;
      operation <= tabela_verdade(i).operation;
      sum       <= tabela_verdade(i).sum;

      wait for 1 ns;

      assert sum = tabela_verdade(i).sum report "A = " & integer'image(to_integer(unsigned(tabela_verdade(i).a)))
      & " B = " & integer'image(to_integer(unsigned(tabela_verdade(i).b)))
      & " Soma/Sub = " & integer'image(to_integer(unsigned(sum)));
      
      write(my_line, string'("true sum = "));
      hwrite(my_line, tabela_verdade(i).sum);
      write(my_line, string'("    sum = "));
      hwrite(my_line, sum);
      writeline(output, my_line);
    end loop;
     report "Fim dos testes";
     wait;
  end process estimulo_checagem;
end;
