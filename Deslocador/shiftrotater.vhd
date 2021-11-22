library ieee;
use ieee.std_logic_1164.all;

entity shiftrotater is
	port(
		din: in std_logic_vector(3 downto 0);
		desloc: in std_logic_vector(1 downto 0);
		shift: in std_logic;
		dout: out std_logic_vector(3 downto 0)
	);
end entity;

architecture structural of shiftrotater is
	signal outinRot: std_logic_vector(3 downto 0):= (others => '0');
	signal outinDes: std_logic_vector(3 downto 0):= (others => '0');
	signal tempRot: std_logic_vector(3 downto 0):= (others => '0');
	signal tempDes: std_logic_vector(3 downto 0):= (others => '0');
begin
	
--Inicio Rotacionador
	rot0: entity work.mux2(behavioral)
		port map(din(0),din(3),desloc(0),outinRot(0));

	rot1: entity work.mux2(behavioral)
		port map(din(1),din(0),desloc(0),outinRot(1));

	rot2: entity work.mux2(behavioral)
		port map(din(2),din(1),desloc(0),outinRot(2));

	rot3: entity work.mux2(behavioral)
		port map(din(3),din(2),desloc(0),outinRot(3));

		
	rot10: entity work.mux2(behavioral)
		port map(outinRot(0),outinRot(2),desloc(1),tempRot(0));
	
	rot11: entity work.mux2(behavioral)
		port map(outinRot(1),outinRot(3),desloc(1),tempRot(1));
	
	rot12: entity work.mux2(behavioral)
		port map(outinRot(2),outinRot(0),desloc(1),tempRot(2));
	
	rot13: entity work.mux2(behavioral)
		port map(outinRot(3),outinRot(1),desloc(1),tempRot(3));
	--Fim Rotacionador
	
	--Inicio Deslocador
	desloc0: entity work.mux2(behavioral)
		port map(din(0),'0',desloc(0),outinDes(0));

	desloc1: entity work.mux2(behavioral)
		port map(din(1),din(0),desloc(0),outinDes(1));

	desloc2: entity work.mux2(behavioral)
		port map(din(2),din(1),desloc(0),outinDes(2));

	desloc3: entity work.mux2(behavioral)
		port map(din(3),din(2),desloc(0),outinDes(3));


	desloc10: entity work.mux2(behavioral)
		port map(outinDes(0),'0',desloc(1),tempDes(0));

	desloc11: entity work.mux2(behavioral)
		port map(outinDes(1),'0',desloc(1),tempDes(1));

	desloc12: entity work.mux2(behavioral)
		port map(outinDes(2),outinDes(0),desloc(1),tempDes(2));

	desloc13: entity work.mux2(behavioral)
		port map(outinDes(3),outinDes(1),desloc(1),tempDes(3));
	--Fim Deslocador


	--Guarda o resultado
	result0: entity work.mux2(behavioral)
		port map(tempRot(0),tempDes(0),shift,dout(0));
	result1: entity work.mux2(behavioral)
		port map(tempRot(1),tempDes(1),shift,dout(1));
	result2: entity work.mux2(behavioral)
		port map(tempRot(2),tempDes(2),shift,dout(2));
	result3: entity work.mux2(behavioral)
		port map(tempRot(3),tempDes(3),shift,dout(3));
end architecture;