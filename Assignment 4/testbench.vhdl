library std;
use std.textio.all;

library ieee;
use ieee.std_logic_1164.all;

entity tb is
end entity;

architecture behave of tb is
    component brentkung is
        port(
            a,b: in std_logic_vector(15 downto 0);
            s: out std_logic_vector(15 downto 0);
            cout: out std_logic;
            cin: in std_logic
        );
    end component;

    signal input_vector: std_logic_vector(32 downto 0);
    signal output_vector: std_logic_vector(16 downto 0);

    function to_string(x: string) return string is
        variable ret_val: string(1 to x'length);
        alias lx : string (1 to x'length) is x;
    begin  
        ret_val := lx;
        return(ret_val);
    end to_string;

    function to_std_logic_vector(x: bit_vector) return std_logic_vector is
        alias lx: bit_vector(1 to x'length) is x;
        variable ret_val: std_logic_vector(1 to x'length);
        begin
            for I in 1 to x'length loop
                if(lx(I) = '1') then
                    ret_val(I) := '1';
                else
                    ret_val(I) := '0';
                end if;
            end loop; 
        return ret_val;
    end to_std_logic_vector;

    function to_bit_vector(x: std_logic_vector) return bit_vector is
        alias lx: std_logic_vector(1 to x'length) is x;
        variable ret_val: bit_vector(1 to x'length);
        begin
            for I in 1 to x'length loop
                if(lx(I) = '1') then
                    ret_val(I) := '1';
                else
                    ret_val(I) := '0';
                end if;
            end loop; 
        return ret_val;
    end to_bit_vector;

    begin
    dut1: brentkung 
    port map(
        a => input_vector(31 downto 16),
        b => input_vector(15 downto 0),
        cin => input_vector(32),
        s => output_vector(15 downto 0),
        cout => output_vector(16)
    );

    main: process
        file infile: text open read_mode is "testcases.txt";
        file outfile: text open write_mode is "results.txt";

        variable in_var: bit_vector (32 downto 0);
        variable out_var: bit_vector (16 downto 0);
        variable flag : boolean := true;
        variable testcase : integer := 0;
        variable input_line: Line;
        variable output_line: Line;

    begin
        while not endfile(infile) loop 
            testcase := testcase + 1;
            readLine(infile, input_line);
            read(input_line, in_var);
            read(input_line, out_var);
            input_vector <= to_std_logic_vector(in_var);
            wait for 10 ns;

            if(output_vector = to_std_logic_vector(out_var)) then
                flag := flag and true;
            else 
                flag := false;
                write(output_line, to_string("Error: Testcase " & integer'image(testcase)));
                writeline(outfile, output_line);
            end if;

            write(output_line, to_bit_vector(input_vector));
            write(output_line, to_string(" "));
            write(output_line, to_bit_vector(output_vector));
            writeline(outfile, output_line);
            wait for 5 ns;
        end loop;
        assert (not flag) report "SUCCESS, All Testcases out of " & integer'image(testcase) & " Passed!" severity note;
        assert (flag) report "FAILURE, Few Testcases out of " & integer'image(testcase) & " Failed" severity error;
        report "Design verification completed";
        wait;
    end process;
end;