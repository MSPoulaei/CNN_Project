library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.utility.all;
use work.PE.all;

entity CNN is
    generic (n_filter : integer :=16);    
    port (
        input:in image_i;
        output:out image_o
    );
    -- n most be factor of 4
end entity CNN;

architecture behavioral of CNN is
    type filters_t is array(0 to n_filter-1) of matrix3x3;
    shared VARIABLE filters : filters_t;
    signal init_done: boolean :=false;
begin
   init_filters: process
   begin
    for k in filters'range loop
        for i in 0 to 2 loop
            for j in 0 to 2 loop
                filters(k)(i,j):=rand_int((i + 1) * (j + 1) * (i + j +1));
            end loop;
        end loop;
    end loop;
    init_done<=true;
    wait;
   end process init_filters;
  logic: process(input,init_done)
    VARIABLE i :integer;
    VARIABLE temp_res_pe: matrix4x4;
    VARIABLE input_binary_sum:array_int_9;
    VARIABLE input_pe_calc:matrix3x3;
    VARIABLE output_temp:image_o;
  begin
    if init_done then
        for i in 0 to 125 loop
            for j in 0 to 125 loop
                output_temp(i, j) := 0;
            end loop;
        end loop;
        for step in 0 to n_filter / 4 - 1 loop
            i:=0;
            while (i < 126 * 126) loop
                for f in 0 to 3 loop --for filter
                    for w in 0 to 3 loop -- for window
                        for index_i in 0 to 2 loop
                            for index_j in 0 to 2 loop
                                input_pe_calc(index_i,index_j):=input((i + w) / 126 + index_i, (i + w) mod 126 + index_j);
                            end loop;
                        end loop;
                        temp_res_pe(f, w) := pe_calc(filters(step*4+f), input_pe_calc);
                    end loop;
                end loop;
                for w in 0 to 3 loop
                    input_binary_sum:=(0=>temp_res_pe(0, w),1=>temp_res_pe(1, w),2=>temp_res_pe(2, w),3=>temp_res_pe(3,w),others => 0);
                    output_temp((i + w) / 126, (i + w) mod 126) := output_temp((i + w) / 126, (i + w) mod 126) + binary_sum(input_binary_sum);
                end loop;
                i:=i+4;
            end loop;
        end loop;
        for i in 0 to 125 loop
            for j in 0 to 125 loop
                output_temp(i, j) := output_temp(i, j) mod 256;
            end loop;
        end loop;
        output<=output_temp;
    end if;
  end process logic;
end architecture behavioral;