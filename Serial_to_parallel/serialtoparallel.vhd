library ieee;
use ieee.std_logic_1164.all;

entity serialtoparallel is 
	generic(
		N: natural := 8
	);
	port(
		serial_in: in std_logic;
		clk: in std_logic;
		data_out: out std_logic_vector(N-1 downto 0)
	);
end entity;

architecture structural of serialtoparallel is

	signal aux: std_logic_vector(N-1 downto 0) := (others => '0');

begin

	ff0: entity work.reg_n(behavioral)
		generic map(1)
    port map(data_in(0) => serial_in, clk => clk,data_out(0) => aux(0));

  data_out(0) <= aux(0);

	reg: for i in 1 to N - 1 generate
		ff: entity work.reg_n(behavioral)
		generic map(1)
    port map(data_in(0) => aux(i-1), clk => clk,data_out(0) => aux(i));
    data_out(i) <= aux(i);
	end generate reg;
	

end architecture;