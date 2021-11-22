library ieee;
library STD; 
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;
use STD.textio.all; 
use IEEE.std_logic_textio.all;   

entity tb_controle_semaforo is
end;

architecture behavioral of tb_controle_semaforo is
      signal clock: std_logic;
      signal alert: std_logic;
      signal ledr: std_logic_vector(17 downto 0);
      signal ledg: std_logic_vector(17 downto 0);
begin
  
  s1b: entity work.controle_semaforo(behavioral)
    port map(clock, alert, ledr, ledg);
  
  estimulo_checagem: process is
    variable my_line : line;
    type reg_controle is record
      clock: std_logic;
      alert: std_logic;
      ledr: std_logic_vector(17 downto 0);
      ledg: std_logic_vector(17 downto 0);
    end record;

    type vet_controle is array(0 to 4) of reg_controle;
    constant tabela_verdade: vet_controle :=
    --   clock  aler out
      (
        ('1','0',"000000000000000001","000000000000000010"),
        ('1','0',"000000000000000011","000000000000000010"),
        ('1','0',"000000000000000010","000000000000000001"),
        ('1','0',"000000000000000011","000000000000000001"),
        ('1','0',"000000000000000001","000000000000000010")
      );
  begin

    for i in tabela_verdade 'range loop
      clock         <= tabela_verdade(i).clock;
      alert         <= tabela_verdade(i).alert;
      ledr <= tabela_verdade(i).ledr;
      ledg <= tabela_verdade(i).ledg;

      wait for 1 ns;

      --assert ledr = tabela_verdade(i).ledr report "verdade = " & integer'image(to_integer(unsigned(tabela_verdade(i).ledr)))
      --& " mentira = " & integer'image(to_integer(unsigned(ledr)));

      write(my_line, string'(" true ledr = "));
      write(my_line, tabela_verdade(i).ledr);
      write(my_line, string'(" false ledr = "));
      write(my_line, ledr);
      writeline(output, my_line);
      
      --assert ledg = tabela_verdade(i).ledr report "verdade = " & integer'image(to_integer(unsigned(tabela_verdade(i).ledg)))
      --& " mentira = " & integer'image(to_integer(unsigned(ledg)));


      write(my_line, string'(" true ledg = "));
      write(my_line, tabela_verdade(i).ledg);
      write(my_line, string'(" false ledg = "));
      write(my_line, ledg);
      writeline(output, my_line);

    end loop;
     report "Fim dos testes";
     wait;
  end process estimulo_checagem;
end;
