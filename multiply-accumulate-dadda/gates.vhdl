-- Rohan Rajesh Kalbag --
-- Roll Number: 20D170033, last digit is 3 --

library IEEE;
use IEEE.std_logic_1164.all;

entity andgate is
    port (A, B: in std_ulogic;
    prod: out std_ulogic);
end entity andgate;

architecture trivial of andgate is
    begin
    prod <= A AND B AFTER 43 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;

entity xorgate is
    port (A, B: in std_ulogic;
    uneq: out std_ulogic);
end entity xorgate;

architecture trivial of xorgate is
    begin
    uneq <= A XOR B AFTER 66 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;

entity abcgate is
    port (A, B, C: in std_ulogic;
    abc: out std_ulogic);
end entity abcgate;

architecture trivial of abcgate is
    begin
    abc <= A OR (B AND C) AFTER 56 ps;
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;

entity Cin_map_G is
    port(A, B, Cin: in std_ulogic;
    Bit0_G: out std_ulogic);
end entity Cin_map_G;

architecture trivial of Cin_map_G is
    begin
    Bit0_G <= (A AND B) OR (Cin AND (A OR B)) AFTER 66 ps;
end architecture trivial;