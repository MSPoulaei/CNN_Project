library CNN;
use CNN.PE.all;
use CNN.utility.all;
use STD.textio.all;
library ieee;
use ieee.std_logic_textio.all;

	-- Add your library and packages declaration here ...

entity cnn_tb is
	-- Generic declarations of the tested unit
		generic(
		n_filter : INTEGER := 4 );
end cnn_tb;

architecture TB_ARCHITECTURE of cnn_tb is
	-- Component declaration of the tested unit
	component cnn
		generic(
		n_filter : INTEGER := 4 );
	port(
		input : in image_i;
		output : out image_o );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal input : image_i;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal output : image_o;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : cnn
		generic map (
			n_filter => n_filter
		)

		port map (
			input => input,
			output => output
		);

	-- Add your stimulus here ...
	testbench: process
	variable v_ILINE     : line;
	variable v_OLINE     : line;
   variable v_comma     : character:=',';
   variable v_bracket_baz     : character:='[';
   variable v_bracket_baste     : character:=']';
   variable temp:integer;
--    file file_handler     : text open write_mode is "out1.txt";
--    Variable row          : line;
    file file_INPUTS : text;
    file file_RESULTS : text;
	begin

		--read image1 pixels
		for ii in 1 to 3 loop
		file_open(file_INPUTS, "src/bits"&integer'image(ii)&".txt",  read_mode);
		for i in 0 to 127 loop
			for j in 0 to 127 loop
				readline(file_INPUTS, v_ILINE);
				read(v_ILINE,temp);
				input(i,j)<=temp;
			end loop;
		end loop;
		file_close(file_INPUTS);

		wait for 100ns;
		--write output 1
		file_open(file_RESULTS, "src/output_results"&integer'image(ii)&".txt", write_mode);
       	for i in 0 to 125 loop
			for j in 0 to 125 loop
				write(v_OLINE, output(i,j));
				if j /= 125 then
					write(v_OLINE, v_comma);
				end if;
			end loop;
			if i/=125 then
				write(v_OLINE, v_comma);
				writeline(file_RESULTS, v_OLINE);
			end if;
       	end loop;
		writeline(file_RESULTS, v_OLINE);
		file_close(file_RESULTS);

	   wait for 200ns;
		end loop;
		wait;
	end process testbench;
end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_cnn of cnn_tb is
	for TB_ARCHITECTURE
		for UUT : cnn
			use entity work.cnn(behavioral);
		end for;
	end for;
end TESTBENCH_FOR_cnn;

