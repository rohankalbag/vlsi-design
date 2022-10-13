-- Rohan Rajesh Kalbag --
-- Roll Number: 20D170033, last digit is 3 --

library IEEE;
use IEEE.std_logic_1164.all;

entity brentkung is
    port(
        a,b: in std_logic_vector(15 downto 0);
        s: out std_logic_vector(15 downto 0);
        cout: out std_logic;
        cin: in std_logic
    );
end entity;

architecture behave of brentkung is
    --signal declarations --
    
        --leaf nodes
        signal p1_i, g1_i: std_logic_vector(15 downto 0);
        -- root node
        signal g5_15_0, p5_15_0: std_logic;
        -- right sub tree --
        signal p2_7_6, g2_7_6: std_logic;
        signal p2_5_4, g2_5_4: std_logic;
        signal p2_3_2, g2_3_2: std_logic;
        signal p2_1_0, g2_1_0: std_logic;
        signal p3_7_4, g3_7_4: std_logic;
        signal p3_3_0, g3_3_0: std_logic;
        signal p4_7_0, g4_7_0: std_logic;
        -- left sub tree --
        signal p2_15_14, g2_15_14: std_logic;
        signal p2_13_12, g2_13_12: std_logic;
        signal p2_11_10, g2_11_10: std_logic;
        signal p2_9_8, g2_9_8: std_logic;
        signal p3_15_12, g3_15_12: std_logic;
        signal p3_11_8, g3_11_8: std_logic;
        signal p4_15_8, g4_15_8: std_logic;

        --carry bits--
        signal c: std_logic_vector(16 downto 0);

    -- component declarations --
    component andgate is
        port (A, B: in std_logic;
        prod: out std_logic);
    end component;

    component xorgate is
        port (A, B: in std_logic;
        uneq: out std_logic);
    end component xorgate;

    component abcgate is
        port (A, B, C: in std_logic;
        abc: out std_logic);
    end component abcgate;

    component Cin_map_G is
        port(A, B, Cin: in std_logic;
        Bit0_G: out std_logic);
    end component Cin_map_G;

begin
    --generate p1_i signals --
    xors: for i in 0 to 15 generate
        xor_i: xorgate port map(a => a(i), b => b(i), uneq => p1_i(i));
    end generate xors;

    --generate g1_i signals --
    ands: for i in 1 to 15 generate
        and_i: andgate port map(a => a(i), b => b(i), prod => g1_i(i));
    end generate ands;

    --generate g1_0 using Cin_map_G
    cmapg_1: Cin_map_G port map(a => a(0), b => b(0), cin => cin, bit0_g => g1_i(0));

    --set the first carry as the value g1_0
    c(1) <= g1_i(0);
    
    --generate p2, g2 signals --
    abc_1: abcgate port map(a => g1_i(1), b => p1_i(1), c => g1_i(0), abc => g2_1_0);
    abc_2: abcgate port map(a => g1_i(3), b => p1_i(3), c => g1_i(2), abc => g2_3_2);
    abc_3: abcgate port map(a => g1_i(5), b => p1_i(5), c => g1_i(4), abc => g2_5_4);
    abc_4: abcgate port map(a => g1_i(7), b => p1_i(7), c => g1_i(6), abc => g2_7_6);
    abc_5: abcgate port map(a => g1_i(9), b => p1_i(9), c => g1_i(8), abc => g2_9_8);
    abc_6: abcgate port map(a => g1_i(11), b => p1_i(11), c => g1_i(10), abc => g2_11_10);
    abc_7: abcgate port map(a => g1_i(13), b => p1_i(13), c => g1_i(12), abc => g2_13_12);
    abc_8: abcgate port map(a => g1_i(15), b => p1_i(15), c => g1_i(14), abc => g2_15_14);
    
    and_1: andgate port map(a =>p1_i(0), b=>p1_i(1), prod=>p2_1_0);
    and_2: andgate port map(a =>p1_i(2), b=>p1_i(3), prod=>p2_3_2);
    and_3: andgate port map(a =>p1_i(4), b=>p1_i(5), prod=>p2_5_4);
    and_4: andgate port map(a =>p1_i(6), b=>p1_i(7), prod=>p2_7_6);
    and_5: andgate port map(a =>p1_i(8), b=>p1_i(9), prod=>p2_9_8);
    and_6: andgate port map(a =>p1_i(10), b=>p1_i(11), prod=>p2_11_10);
    and_7: andgate port map(a =>p1_i(12), b=>p1_i(13), prod=>p2_13_12);
    and_8: andgate port map(a =>p1_i(14), b=>p1_i(15), prod=>p2_15_14);

    --generate p3, g3 signals --
    abc_9: abcgate port map(a => g2_15_14, b => p2_15_14, c => g2_13_12, abc => g3_15_12);
    abc_10: abcgate port map(a => g2_11_10, b => p2_11_10, c => g2_9_8, abc => g3_11_8);
    abc_11: abcgate port map(a => g2_7_6, b => p2_7_6, c => g2_5_4, abc => g3_7_4);
    abc_12: abcgate port map(a => g2_3_2, b => p2_3_2, c => g2_1_0, abc => g3_3_0);

    and_9: andgate port map(a =>p2_15_14, b=>p2_13_12, prod=>p3_15_12);
    and_10: andgate port map(a =>p2_11_10, b=>p2_9_8, prod=>p3_11_8);
    and_11: andgate port map(a =>p2_7_6, b=>p2_5_4, prod=>p3_7_4);
    and_12: andgate port map(a =>p2_3_2, b=>p2_1_0, prod=>p3_3_0);

    --generate p4, g4 signals --
    abc_13: abcgate port map(a => g3_15_12, b => p3_15_12, c => g3_11_8, abc => g4_15_8);
    abc_14: abcgate port map(a => g3_7_4, b => p3_7_4, c => g3_3_0, abc => g4_7_0);
    
    and_13: andgate port map(a =>p3_15_12, b=>p3_11_8, prod=>p4_15_8);
    and_14: andgate port map(a =>p3_7_4, b=>p3_3_0, prod=>p4_7_0);

    --generate g5, p5 signals --
    abc_15: abcgate port map(a => g4_15_8, b => p4_15_8, c => g4_7_0, abc => g5_15_0);

    and_15: andgate port map(a => p4_15_8, b => p4_7_0, prod=>p5_15_0);

    --generate carry signals --
    abc_c2: abcgate port map(b => p2_1_0, a=>g2_1_0, c=>cin, abc => c(2));
    abc_c3: abcgate port map(b => p1_i(2), a=>g1_i(2), c=>c(2), abc => c(3));
    abc_c4: abcgate port map(b => p3_3_0, a=>g3_3_0, c=>cin, abc => c(4));
    abc_c5: abcgate port map(b => p1_i(4), a=>g1_i(4), c=>c(4), abc => c(5));
    abc_c6: abcgate port map(b => p2_5_4, a=>g2_5_4, c=>c(4), abc => c(6));
    abc_c7: abcgate port map(b => p1_i(6), a=>g1_i(6), c=>c(6), abc => c(7));
    abc_c8: abcgate port map(b => p4_7_0, a=>g4_7_0, c=>cin, abc => c(8));
    abc_c9: abcgate port map(b => p1_i(8), a=>g1_i(8), c=>c(8), abc => c(9));
    abc_c10: abcgate port map(b => p2_9_8, a=>g2_9_8, c=>c(8), abc => c(10));
    abc_c11: abcgate port map(b => p1_i(10), a=>g1_i(10), c=>c(10), abc => c(11));
    abc_c12: abcgate port map(b => p3_11_8, a=>g3_11_8, c=>c(8), abc => c(12));
    abc_c13: abcgate port map(b => p1_i(12), a=>g1_i(12), c=>c(12), abc => c(13));
    abc_c14: abcgate port map(b => p2_13_12, a=>g2_13_12, c=>c(12), abc => c(14));
    abc_c15: abcgate port map(b => p1_i(14), a=>g1_i(14), c=>c(14), abc => c(15));
    abc_c16: abcgate port map(b => p5_15_0, a=>g5_15_0, c=>cin, abc => c(16));

    --sum signals--
    sumxors: for i in 0 to 15 generate
        sum_xor_i: xorgate port map(a => p1_i(i), b => c(i), uneq => s(i));
    end generate sumxors;

    --carry out and carry in--
    c(0) <= cin;
    cout <= c(16);
end behave;