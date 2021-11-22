library ieee;
library STD; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use STD.textio.all; 
use IEEE.std_logic_textio.all;   

entity tb_reg_n is
end;

architecture behavioral of tb_reg_n is
	signal data_in: std_logic_vector(0 downto 0);
	signal clk: std_logic;
	signal data_out: std_logic_vector(0 downto 0);
begin
  
  s1b: entity work.reg_n(behavioral)
    port map(data_in, clk, data_out);
  
  estimulo_checagem: process is
    variable my_line : line;
    type reg_somador is record
			data_in: std_logic_vector(0 downto 0);
			clk: std_logic;
			data_out: std_logic_vector(0 downto 0);
    end record;

    type vet_somador is array(0 to 3) of reg_somador;
    constant tabela_verdade: vet_somador :=
    --   in  clk out
      (
      	("0",'1',"0"),
      	("0",'0',"0"),
      	("1",'1',"1"),
      	("1",'0',"1")
      );
  begin

    for i in tabela_verdade 'range loop
      data_in         <= tabela_verdade(i).data_in;
      clk         <= tabela_verdade(i).clk;
      data_out <= tabela_verdade(i).data_out;

      wait for 1 ns;

      --assert data_out = tabela_verdade(i).data_out report "data_in = " & integer'image(to_integer(unsigned(tabela_verdade(i).data_in)))
      --& " clk = " & integer'image(to_integer(unsigned(tabela_verdade(i).clk)))
      --& " data_out = " & integer'image(to_integer(unsigned(data_out)));
      
      write(my_line, string'("true data_out = "));
      write(my_line, tabela_verdade(i).data_out);
      write(my_line, string'("    data_out = "));
      write(my_line, data_out);
      writeline(output, my_line);
    end loop;
     report "Fim dos testes";
     wait;
  end process estimulo_checagem;
end;
