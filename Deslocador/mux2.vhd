library ieee;
use ieee.std_logic_1164.all;

entity mux2 is
	port(
		i0, i1: in std_logic;
		sel: in std_logic;
		s: out std_logic
	);
end entity;

architecture behavioral of mux2 is
begin
	
	process(sel)
	begin
		if sel = '0' then
			s <= i0;
		elsif sel = '1' then
			s <= i1;
		end if;
	end process;
end architecture;
