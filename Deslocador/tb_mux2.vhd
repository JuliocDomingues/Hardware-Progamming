library ieee;
use ieee.std_logic_1164.all;

entity tb_mux2 is 
end;

architecture behavioral of tb_mux2 is
	signal in0, in1, sele, mout: std_logic;
begin
	
	outmux: entity work.mux2(behavioral)
		port map(in0, in1, sele, mout);

	check: process is

		type reg_mux is record
			in0, in1, sele, mout: std_logic;
		end record;

		type vet_mux is array(0 to 7) of reg_mux;
		constant table: vet_mux :=
		--  in0 in1 sele mout
			(('0','0','0','0'),
			 ('0','0','1','0'),
			 ('0','1','0','0'),
			 ('0','1','1','1'),
			 ('1','0','0','1'),
			 ('1','0','1','0'),
			 ('1','1','0','1'),
			 ('1','1','1','1'));
		begin

			for i in table 'range loop
				in0  <= table(i).in0;
				in1  <= table(i).in1;
				sele <= table(i).sele;

				wait for 1 ns;
				assert mout = table(i).mout report "Erro";
			end loop;

			report "Fim dos testes";
			wait;
	end process;
end;