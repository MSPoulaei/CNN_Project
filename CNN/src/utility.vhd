LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

package utility is
    
    IMPURE FUNCTION rand_int(seed : INTEGER) RETURN integer;
    type array_int_9 is array(0 to 8) of integer;
    FUNCTION binary_sum(a:array_int_9) RETURN INTEGER;
    type matrix3x3 is array(0 to 2, 0 to 2) of INTEGER;
    type matrix4x4 is array(0 to 3, 0 to 3) of integer;
	type image_i is array(0 to 127,0 to 127) of integer;
    type image_o is array(0 to 125, 0 to 125) of integer;
    
end package utility;

package body utility is
    
    
    IMPURE FUNCTION rand_int(seed : INTEGER) RETURN integer IS
        VARIABLE r: integer;
        VARIABLE r_bin:std_logic_vector(15 downto 0);
    BEGIN			   
        r:=seed;
        r_bin:=std_logic_vector(to_unsigned(r,r_bin'length));
        r:=0;
        for i in r_bin'range loop
            if r_bin(i) = '1' then
            r:=r+1;
            end if;
        end loop;
        RETURN r mod 2;
    END FUNCTION;

    FUNCTION binary_sum(a:array_int_9) RETURN INTEGER IS
        type matrix5x9 is array(0 to 4,0 to 8) of integer;
        VARIABLE temp : matrix5x9;
        VARIABLE res,x:integer;
    BEGIN
        for i in 0 to 8 loop--init first row of temp
            temp(0,i):=a(i);--level 0
        end loop;
        for i in 3 downto 1 loop--level 1 to 3
            x:=1;
            for k in 1 to i-1 loop
                x:=x*2;
            end loop;
            x:=x-1;
            for j in 0 to x loop
                temp(3 - i + 1, j) := temp(3 - i, 2 * j) + temp(3 - i, 2 * j + 1);
            end loop;
        end loop;
        res:= temp(3, 0) + temp(0, 8);--level 4
        RETURN res;
    END FUNCTION;
    
end package body utility;
--temp
--  0 1  2 3  4 5  6 7  8
--  01   23   45  67
--  0123   4567 
--  01234567
--  012345678