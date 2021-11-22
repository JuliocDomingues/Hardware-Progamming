library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.ALL;

entity tb_shiftrotater is 
end;


architecture hibrida of tb_shiftrotater is
	signal din: std_logic_vector(3 downto 0) := (others => '-');
	signal desloc: std_logic_vector(1 downto 0) := (others => '-');
	signal dout: std_logic_vector(3 downto 0) := (others => '-');
	signal shift: std_logic := '-';
begin
	
	outshift: entity work.shiftrotater(structural)
		port map(din, desloc, shift, dout);

	check: process is

		type reg_shift is record
			din: std_logic_vector(3 downto 0);
			desloc: std_logic_vector(1 downto 0);
			shift: std_logic;
			dout: std_logic_vector(3 downto 0);
		end record;

		type vet_shift is array(natural range <>) of reg_shift;
		constant table: vet_shift :=
			(("1001","00",'0',"1001"),
			 ("1001","01",'0',"0011"),
			 ("1001","10",'0',"0110"),
			 ("1001","11",'0',"1100"),
			 ("1001","00",'1',"1001"),
			 ("1001","01",'1',"0010"),
			 ("1001","10",'1',"0100"),
			 ("1001","11",'1',"1000")
			 );
		begin

			for i in table 'range loop
				din <= table(i).din;
				desloc <= table(i).desloc;
				shift <= table(i).shift;

				wait for 1 ns;

				if dout = table(i).dout then
					report "Saida esperada = " & integer'image(to_integer(unsigned(table(i).dout))) &
					" Saida intelijente = " & integer'image(to_integer(unsigned(dout)));
				end if;

				assert dout = table(i).dout report "Saida esperada = " & integer'image(to_integer(unsigned(table(i).dout))) &
				" Saida burra = " & integer'image(to_integer(unsigned(dout)));
			end loop;
			report "Fim dos testes";
			wait;
	end process check;
end;