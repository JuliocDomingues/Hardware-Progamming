library ieee;
use ieee.std_logic_1164.all;

entity paralleltoserial is 
	generic(
		N: natural := 8
	);
	port(
		data_in: in std_logic_vector(N-1 downto 0);
		serialize_load: in std_logic;
		clk: in std_logic;
		serial_out: out std_logic
	);
end entity;

architecture structural of paralleltoserial is
	signal firstAnd: std_logic_vector(N-1 downto 0) := (others => '0');
	signal secondAnd: std_logic_vector(N-1 downto 0) := (others => '0');
	signal outOr: std_logic_vector(N-2 downto 0) := (others => '0');
	signal outFlip: std_logic_vector(N-1 downto 0) := (others => '0');
begin
	
	-- n flok no meu flink
	n_fliflop: for i in 0 to N - 1 generate

		zero_if: if i = 0 generate
			firstAnd(i) <= data_in(i) and (not serialize_load);

			zero_flop: entity work.reg_n(behavioral)
				generic map( N => 1 )
				port map(data_in(0) => firstAnd(i), clk => clk,data_out(0) => outFlip(i));
		end generate zero_if;

		others_if: if (i /= 0) generate
			firstAnd(i)  <= outFlip(i-1) and serialize_load;
			secondAnd(i) <= (not serialize_load) and data_in(i);

			outOr(i-1) <= firstAnd(i) or secondAnd(i);

			others_flop: entity work.reg_n(behavioral)
			generic map( N => 1 )
	    port map(data_in(0) => outOr(i-1), clk => clk,data_out(0) => outFlip(i));
		
	  end generate others_if;

	  last_if: if i = N - 1 generate
			firstAnd(i)  <= outFlip(i-1) and serialize_load;
			secondAnd(i) <= (not serialize_load) and data_in(N-1);

			outOr(i-1) <= firstAnd(i) or secondAnd(i);

			last_flop: entity work.reg_n(behavioral)
			generic map( N => 1 )
	    port map(data_in(0) => outOr(i-1), clk => clk,data_out(0) => serial_out);

		end generate last_if;

	end generate n_fliflop;	
end architecture;