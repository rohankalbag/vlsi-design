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
    signal s: std_logic_vector(15 downto 0);
    signal cout: std_logic;

    begin
    dut1: brentkung 
    port map(
        a => a,
        b => b,
        cin => cin,
        s => s,
        cout => cout
    );

    main: process
    begin
        a <= x"0032";
        b <= x"0001";
        cin <= '0';
        wait for 10 ns;
        a <= x"004F";
        b <= x"EECA";
        cin <= '0';
        wait for 10 ns;
        a <= x"FFFF";
        b <= x"0000";
        cin <= '1';
        wait for 10 ns;
        report "Testing completed";
        wait;
    end process;
end;
