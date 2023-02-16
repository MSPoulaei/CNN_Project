library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.utility.all;


package PE is
    FUNCTION pe_calc(filter,input:matrix3x3) RETURN INTEGER;
end package PE;

package body PE is
    FUNCTION pe_calc(filter,input:matrix3x3) RETURN INTEGER IS
    VARIABLE ans:integer;
    VARIABLE temp:array_int_9;
    BEGIN
    ans := 0;
    for i in 0 to 2 loop
        for j in 0 to 2 loop
            temp(i*3+j):=filter(i,j) * input(i,j);
        end loop;
    end loop;
    ans:=binary_sum(temp);
    RETURN ans;
    END FUNCTION;
end package body PE;