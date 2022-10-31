-- Rohan Rajesh Kalbag --
-- Roll Number: 20D170033, last digit is 3 --

library IEEE;
use IEEE.std_logic_1164.all;

entity multiply_accumulate is 
    --perform ab + c --
    port(
        a, b: in std_logic_vector(7 downto 0);
        c: in std_logic_vector(15 downto 0);
        s: out std_logic_vector(15 downto 0);
        cout: out std_logic
    );
end entity;

architecture behave of multiply_accumulate is
    -- component declarations --
    component andgate is
        port (A, B: in std_logic;
        prod: out std_logic);
    end component;

    component fa is 
        port(
            a,b,cin: in std_logic;
            s,cout: out std_logic
        );
    end component;

    component ha is
        port(
            a,b: in std_logic;
            s, c: out std_logic
        );
    end component;

    component brentkung is
        port(
            a,b: in std_logic_vector(15 downto 0);
            s: out std_logic_vector(15 downto 0);
            cout: out std_logic;
            cin: in std_logic
        );
    end component;

    signal gnd_sig: std_logic := '0';

    --layer 1 signal declarations--
    signal layer1_r1: std_logic_vector(15 downto 0);
    signal layer1_r2: std_logic_vector(15 downto 0);
    signal layer1_r3: std_logic_vector(15 downto 0);
    signal layer1_r4: std_logic_vector(15 downto 0);
    signal layer1_r5: std_logic_vector(15 downto 0);
    signal layer1_r6: std_logic_vector(15 downto 0);
    signal layer1_r7: std_logic_vector(15 downto 0);
    signal layer1_r8: std_logic_vector(15 downto 0);
    signal layer1_r9: std_logic_vector(15 downto 0);

    -- signals for connections--
    signal wires: std_logic_vector(100 downto 0);
    
    -- final sum argument signals--
    signal arg1: std_logic_vector(15 downto 0);
    signal arg2: std_logic_vector(15 downto 0);

begin

    layer1_r1 <= c;

    a1: for i in 0 to 7 generate
        and_i: andgate port map(a => b(i), b => a(0), prod => layer1_r2(i)); 
    end generate a1;

    a2: for i in 0 to 7 generate
        and_i: andgate port map(a => b(i), b => a(1), prod => layer1_r3(i + 1)); 
    end generate a2;

    a3: for i in 0 to 7 generate
        and_i: andgate port map(a => b(i), b => a(2), prod => layer1_r4(i + 2)); 
    end generate a3;

    a4: for i in 0 to 7 generate
        and_i: andgate port map(a => b(i), b => a(3), prod => layer1_r5(i + 3)); 
    end generate a4;
    
    a5: for i in 0 to 7 generate
        and_i: andgate port map(a => b(i), b => a(4), prod => layer1_r6(i + 4)); 
    end generate a5;

    a6: for i in 0 to 7 generate
        and_i: andgate port map(a => b(i), b => a(5), prod => layer1_r7(i + 5)); 
    end generate a6;
    
    a7: for i in 0 to 7 generate
        and_i: andgate port map(a => b(i), b => a(6), prod => layer1_r8(i + 6)); 
    end generate a7;
    
    a8: for i in 0 to 7 generate
        and_i: andgate port map(a => b(i), b => a(7), prod => layer1_r9(i + 7)); 
    end generate a8;

    --column 1--
    arg1(0) <= layer1_r1(0);
    arg2(0) <= layer1_r2(0);
    --column 2--
    arg2(1) <= layer1_r3(1);
    h1: ha port map(a => layer1_r1(1), b => layer1_r2(1), s => arg1(1), c => arg2(2));
    --column 3--
    h2: ha port map(a => layer1_r1(2), b => layer1_r2(2), s => wires(0), c => wires(1));
    f1: fa port map(a => wires(0), b => layer1_r3(2), cin=> layer1_r4(2), s => arg1(2), cout => arg2(3));
    --column 4--
    h3: ha port map(a => layer1_r1(3), b => layer1_r2(3), s => wires(2), c => wires(3));
    f2: fa port map(a => wires(2), b => layer1_r3(3), cin => layer1_r4(3), s => wires(4), cout => wires(5));
    f3: fa port map(a => layer1_r5(3), b => wires(1), cin => wires(4), s => arg1(3), cout => arg2(4));
    --column 5--
    f4: fa port map(a => layer1_r1(4), b => layer1_r2(4), cin => layer1_r3(4), s => wires(6), cout => wires(7));
    h4: ha port map(a => layer1_r4(4), b => layer1_r5(4), s => wires(8), c => wires(9));
    f5: fa port map(a => wires(6), b => wires(8), cin => wires(5), s =>wires(10), cout =>wires(11));
    f6: fa port map(a => wires(10), b => wires(5), cin => layer1_r6(4), s => arg1(4), cout =>arg2(5));
    --column 6--
    h5: ha port map(a => layer1_r1(5), b => layer1_r2(5), s =>wires(12), c =>wires(13));
    f7: fa port map(a => wires(12), b => layer1_r3(5), cin => layer1_r4(5), s => wires(14), cout =>wires(15));
    f8: fa port map(a => layer1_r5(5), b => layer1_r6(5), cin => layer1_r7(5), s => wires(16), cout =>wires(17));
    f9: fa port map(a => wires(14), b => wires(16), cin => wires(7), s => wires(18), cout =>wires(19));
    f10: fa port map(a => wires(18), b => wires(9) , cin => wires(11), s => arg1(5), cout => arg2(6));
    --column 7--
    f11: fa port map(a => layer1_r1(6), b => layer1_r2(6), cin => layer1_r3(6), s => wires(20), cout => wires(21));
    h6: ha port map(a => layer1_r4(5), b => layer1_r5(5), s =>wires(21), c =>wires(22));
    f12: fa port map(a => wires(20), b => wires(21), cin => wires(13), s => wires(23), cout => wires(24));
    f13: fa port map(a => layer1_r6(6), b => layer1_r7(6), cin => layer1_r8(6), s => wires(25), cout => wires(26));
    f14: fa port map(a => wires(23), b => wires(25), cin => wires(15), s => wires(27), cout => wires(28));
    f15: fa port map(a => wires(27), b => wires(17), cin => wires(19), s => arg1(6), cout => arg2(7));
    --column 8--
    f16: fa port map(a => layer1_r1(7), b => layer1_r2(7), cin => layer1_r3(7), s => wires(29), cout => wires(30));
    f17: fa port map(a => layer1_r4(7), b => layer1_r5(7), cin => layer1_r6(7), s => wires(31), cout => wires(32));
    h7: ha port map(a => layer1_r7(7), b => layer1_r8(7), s => wires(33), c => wires(34));
    f18: fa port map(a=>wires(29), b=>wires(31), cin=>wires(21), s=>wires(35), cout=>wires(36));
    f19: fa port map(a=>wires(33), b=>layer1_r9(7), cin=>wires(22), s=>wires(37), cout=>wires(38));
    f20: fa port map(a=>wires(35), b=>wires(37), cin=>wires(24), s=>wires(39), cout=>wires(40));
    f21: fa port map(a=>wires(39), b=>wires(26), cin=>wires(28), s=>arg1(7), cout=>arg2(8));
    --column 9--
    f22: fa port map(a=>layer1_r1(8), b=>layer1_r3(8), cin=>layer1_r4(8), s=>wires(41), cout=>wires(42));
    f23: fa port map(a=>layer1_r5(8), b=>layer1_r6(8), cin=>layer1_r7(8), s=>wires(43), cout=>wires(44));
    h8: ha port map(a=>layer1_r8(8), b=>layer1_r9(8), s=>wires(45), c=>wires(46));
    f24: fa port map(a=>wires(41), b=>wires(30), cin=>wires(43), s=>wires(47), cout=>wires(48));
    f25: fa port map(a=>wires(45), b=>wires(32), cin=>wires(34), s=>wires(49), cout=>wires(50));
    f26: fa port map(a=>wires(47), b=>wires(49), cin=>wires(36), s=>wires(51), cout=>wires(52));
    f27: fa port map(a=>wires(38), b=>wires(51), cin=>wires(40), s=>arg1(8), cout=>arg2(9));
    --column 10--
    f28: fa port map(a=>layer1_r1(9), b=>layer1_r4(9), cin=>layer1_r5(9), s=>wires(53), cout=>wires(54));
    f29: fa port map(a=>layer1_r6(9), b=>layer1_r7(9), cin=>layer1_r8(9), s=>wires(55), cout=>wires(56));
    f30: fa port map(a=>wires(53), b=>wires(55), cin=>wires(42), s=>wires(57), cout=>wires(58));
    f31: fa port map(a=>layer1_r9(9), b=>wires(44), cin=>wires(46), s=>wires(59), cout=>wires(60));
    f32: fa port map(a=>wires(57), b=>wires(59), cin=>wires(48), s=>wires(61), cout=>wires(62));
    f33: fa port map(a=>wires(50), b=>wires(52), cin=>wires(61), s=>arg1(9), cout=>arg2(10));
    --column 11--
    f34: fa port map(a=>layer1_r1(10), b=>layer1_r5(10), cin=>layer1_r6(10), s=>wires(63), cout=>wires(64));
    f35: fa port map(a=>wires(63), b=>layer1_r7(10), cin=>wires(54), s=>wires(65), cout=>wires(66));
    f36: fa port map(a=>wires(56), b=>layer1_r8(10), cin=>layer1_r9(10), s=>wires(67), cout=>wires(68));
    f37: fa port map(a=>wires(65), b=>wires(67), cin=>wires(58), s=>wires(69), cout=>wires(70));
    f38: fa port map(a=>wires(60), b=>wires(62), cin=>wires(69), s=>arg1(10), cout=>arg2(11));
    --column 12--
    f39: fa port map(a=>layer1_r1(11), b=>layer1_r6(11), cin=>wires(64), s=>wires(71), cout=>wires(72));
    f40: fa port map(a=>layer1_r7(11), b=>layer1_r8(11), cin=>layer1_r9(11), s=>wires(73), cout=>wires(74));
    f41: fa port map(a=>wires(71), b=>wires(73), cin=>wires(66), s=>wires(75), cout=>wires(76));
    f42: fa port map(a=>wires(68), b=>wires(70), cin=>wires(75), s=>arg1(11), cout=>arg2(12));
    --column 13--
    f43: fa port map(a=>layer1_r1(12), b=>layer1_r7(12), cin=>layer1_r8(12), s=>wires(77), cout=>wires(78));
    f44: fa port map(a=>layer1_r9(12), b=>wires(77), cin=>wires(72), s=>wires(79), cout=>wires(80));
    f45: fa port map(a=>wires(74), b=>wires(76), cin=>wires(79), s=>arg1(12), cout=>arg2(13));
    --column 14--
    f46: fa port map(a=>layer1_r1(13), b=>layer1_r8(13), cin=>wires(78), s=>wires(81), cout=>wires(82));
    f47: fa port map(a=>layer1_r9(13), b=>wires(80), cin=>wires(81), s=>arg1(13), cout=>arg2(14));
    --column 15--
    f48: fa port map(a=>layer1_r1(14), b=>layer1_r9(14), cin=>wires(82), s=>arg1(14), cout=>arg2(15));
    --column 16--
    arg1(15) <= layer1_r1(15);
    --final adder--
    bkadder: brentkung port map(a =>arg1, b=>arg2, cin=>gnd_sig, s=>s, cout=>cout);

end behave;
