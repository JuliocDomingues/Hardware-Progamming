library ieee;
library STD; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use STD.textio.all; 
use IEEE.std_logic_textio.all;   

entity tb_andor is
end;

architecture behavioral of tb_andor is
  signal a, b, s: std_logic_vector(5 downto 0):= (others => '0');
  signal operation: std_logic :='0';
begin
  
  s1b: entity work.andor(behavioral)
    port map(a, b, operation, s);
  
  estimulo_checagem: process is

    variable my_line : line;

    type reg_somador is record
      a, b: std_logic_vector(5 downto 0);
  		operation: std_logic;
  		s: std_logic_vector(5 downto 0);
    end record;

    type vet_somador is array(0 to 7) of reg_somador;
    constant tabela_verdade: vet_somador :=
    --     a        b       op    Or/And
      (("000000", "000000", '0', "000000"),
       ("000100", "000001", '0', "000101"),
       ("011000", "001001", '0', "011001"),
       ("000100", "000100", '0', "000100"),
       ("011001", "001110", '1', "001000"),
       ("011110", "000110", '1', "000110"),
       ("001111", "001001", '1', "001001"),
       ("010110", "010001", '1', "010000"));
  begin

    for i in tabela_verdade 'range loop
      a         <= tabela_verdade(i).a;
      b         <= tabela_verdade(i).b;
      operation <= tabela_verdade(i).operation;
      s       <= tabela_verdade(i).s;

      wait for 1 ns;

      assert s = tabela_verdade(i).s report "A = " & integer'image(to_integer(unsigned(tabela_verdade(i).a)))
      & " B = " & integer'image(to_integer(unsigned(tabela_verdade(i).b)))
      & " Soma/Sub = " & integer'image(to_integer(unsigned(s)));
      
      write(my_line, string'("true s = "));
      write(my_line, tabela_verdade(i).s);
      write(my_line, string'("    s = "));
      write(my_line, s);
      writeline(output, my_line);
    end loop;
     report "Fim dos testes";
     wait;
  end process estimulo_checagem;
end;
