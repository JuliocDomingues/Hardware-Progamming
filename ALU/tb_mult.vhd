library ieee;
library STD; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use STD.textio.all; 
use IEEE.std_logic_textio.all;   

entity tb_mult is
end;

architecture behavioral of tb_mult is
  signal input0, input1: std_logic_vector(3 downto 0);
  signal sel: std_logic;
  signal output: std_logic_vector(3 downto 0);
begin
  
  s1b: entity work.multiplex2x1(behavioral)
    port map(input0, input1, sel, output);
  
  estimulo_checagem: process is
    --variable my_line : line;
    type reg_somador is record
		  input0, input1: std_logic_vector(3 downto 0);
		  sel: std_logic;
		  output: std_logic_vector(3 downto 0);
    end record;

    type vet_somador is array(0 to 7) of reg_somador;
    constant tabela_verdade: vet_somador :=
    --   in1      in2   sel    out 
      (("0001", "1000", '0', "0001"),
       ("0010", "0100", '0', "0010"),
       ("0011", "0010", '0', "0011"),
       ("0100", "0001", '0', "0100"),
       ("0101", "0010", '1', "0010"),
       ("0110", "0100", '1', "0100"),
       ("0111", "1000", '1', "1000"),
       ("1111", "0100", '1', "0100"));
  begin

    for i in tabela_verdade 'range loop
      input0         <= tabela_verdade(i).input0;
      input1         <= tabela_verdade(i).input1;
      sel            <= tabela_verdade(i).sel;
      output         <= tabela_verdade(i).output;

      wait for 1 ns;

      assert output = tabela_verdade(i).output report "A = " & integer'image(to_integer(unsigned(tabela_verdade(i).input0)))
      & " B = " & integer'image(to_integer(unsigned(tabela_verdade(i).input1)))
      & " Soma/Sub = " & integer'image(to_integer(unsigned(output)));
      
      --write(my_line, string'("true output = "));
      --hwrite(my_line, tabela_verdade(i).output);
      --write(my_line, string'("    output = "));
      --hwrite(my_line, output);
      --writeline(output, my_line);
    end loop;
     report "Fim dos testes";
     wait;
  end process estimulo_checagem;
end;
