library ieee;
library STD; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use STD.textio.all; 
use IEEE.std_logic_textio.all;   

entity tb_alu is
end;

architecture behavioral of tb_alu is
  signal a, b, s: std_logic_vector(7 downto 0):= (others => '0');
  signal operation: std_logic_vector(2 downto 0) := (others => '0');
begin
  
  s1b: entity work.alu(structural)
    port map(a, b, operation, s);
  
  estimulo_checagem: process is
    variable my_line : line;
    type reg_somador is record
      a, b: std_logic_vector(7 downto 0);
  		operation: std_logic_vector(2 downto 0);
  		s: std_logic_vector(7 downto 0);
    end record;

    type vet_somador is array(0 to 3) of reg_somador;
    constant tabela_verdade: vet_somador :=
    --      a           b        op    s/sub
      (("00000000", "00001000", "000", "00001000"),
       ("00000011", "00010010", "010", "00000010"),
       ("00101000", "00000110", "101", "00100010"),
       ("10010010", "00000011", "001", "10010101"));
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
      hwrite(my_line, tabela_verdade(i).s);
      write(my_line, string'("    s = "));
      hwrite(my_line, s);
      writeline(output, my_line);
    end loop;
     report "Fim dos testes";
     wait;
  end process estimulo_checagem;
end;
