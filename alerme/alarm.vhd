library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_misc.all;

entity alarm is
	generic(
		N: natural
	);
	port(
		sensors: in std_logic_vector(0 to N-1);
		key: in std_logic;
		clock: in std_logic;
		siren: out std_logic
	);
end entity;

architecture behavioral of alarm is
	type state_type is (A, B, C, D, E);
	signal current_state, next_state: state_type := A;
	signal temp_timer_cont: std_logic := '0';
	signal temp_timer:      std_logic := '0';
begin
	
	process(clock, current_state)
	begin
		if key = '0' then	
			current_state <= A;
		elsif(clock'event and clock = '1') then
			current_state <= next_state;
			siren <= temp_siren;
		end if;
	end process;


	process
	variable temp_cont: natural := 0;
	begin
		temp_timer_cont <= '0';
		loop
			loop
				wait until clock = '1' or temp_timer = '0';
	        exit when temp_timer = '0';
	        temp_cont := temp_cont + 1;
	        if temp_cont > 30 then
	          temp_timer_cont <= '1';
	          temp_timer <= '0';
	        else
	          temp_timer_cont <= '0';
	      	end if;
	    end loop;
	    temp_cont := 0;
	    temp_timer_cont <= '0';
	  end loop;
  end process;

	process(sensors, key, clock, current_state)
	begin
		case current_state is
			
			when A => --Alarme desligado
			--wait until key = '0' for 30 sec;
				if key = '0' then
					next_state <= A;
				else
					next_state <= B;
				end if;
				temp_timer <= '0';

			when B => --Alarme ligando
				if key = '0' then
					next_state <= A;
				elsif temp_timer_cont = '1' then
					--wait until key = '0' for 30 sec;
					next_state <= C;
				end if;
					temp_timer <= '1';

			when C => --Alarme ligado
				if key = '0' then
					next_state <= A;
				elsif OR_REDUCE(sensors) = '1' then
					next_state <= D;
				elsif OR_REDUCE(sensors) = '0' then
					next_state <= C;
				end if;
				temp_timer <= '0';

			when D => --Sirene ligando
				if key = '0' then
					next_state <= A;
				elsif temp_timer_cont = '1' then
					--wait until key = '0' for 30 sec;
					next_state <= E;
				end if;
					temp_timer <= '1';

			when E => --Sirene ligada
				if key = '0' then
					next_state <= A;
				else
					next_state <= E;
				end if;
		end case;
	end process;

	process(current_state)
	begin
		if current_state = E then
			siren <= '1';
		else
			siren <= '0';
		end if;
	end process;

end architecture;