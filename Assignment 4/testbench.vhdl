-- device under test --
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

    signal a,b: std_logic_vector(15 downto 0);
    signal cin: std_logic;
    signal output_vector: std_logic_vector(16 downto 0);

    -- output vector : <cout | sumbits> --

    begin
    dut1: brentkung 
    port map(
        a => a,
        b => b,
        cin => cin,
        s => output_vector(15 downto 0),
        cout => output_vector(16)
    );

    main: process
        variable flag : boolean := true;
        variable currflag: boolean := true;
        variable testcase : integer := 1;
    begin
        
        a <= x"0032";
        b <= x"0001";
        cin <= '0';
        wait for 10 ns;
        if(output_vector = "0" & x"0033") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;
        
        a <= x"CE6F";
        b <= x"EEDA";
        cin <= '0';
        wait for 10 ns;
        if(output_vector = "1" & x"BD49") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;
        
        a <= x"CE6F";
        b <= x"EEDA";
        cin <= '1';
        wait for 10 ns;
        if(output_vector = "1" & x"BD4A") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;
        
        a <= x"F04F";
        b <= x"AECB";
        cin <= '1';
        wait for 10 ns;
        if(output_vector = "1" & x"9F1B") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;

        a <= x"FFFF";
        b <= x"0000";
        cin <= '1';
        wait for 10 ns;
        if(output_vector = "1" & x"0000") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;

        a <= x"ABCD";
        b <= x"BCDE";
        cin <= '0';
        wait for 10 ns;
        if(output_vector = "1" & x"68AB") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;

        a <= x"A00C";
        b <= x"BB4C";
        cin <= '0';
        wait for 10 ns;
        if(output_vector = "1" & x"5B58") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;

        a <= x"007F";
        b <= x"007F";
        cin <= '0';
        wait for 10 ns;
        if(output_vector = "0" & x"00FE") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;

        a <= x"1FFF";
        b <= x"1FFF";
        cin <= '0';
        wait for 10 ns;
        if(output_vector = "0" & x"3FFE") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;

        a <= x"FCCF";
        b <= x"271C";
        cin <= '0';
        wait for 10 ns;
        if(output_vector = "1" & x"23EB") then
            currflag := true;
            flag := flag and true;
        else 
            flag := false;
            currflag := false;
        end if;
        assert (currflag) report "Error: Testcase " & integer'image(testcase) severity error;
        testcase := testcase + 1;

        assert (not flag) report "SUCCESS, All Testcases out of " & integer'image(testcase) & " Passed!" severity note;
        assert (flag) report "FAILURE, Few Testcases out of " & integer'image(testcase) & " Failed" severity error;
        report "Design verification completed";
        wait;
    end process;
end;