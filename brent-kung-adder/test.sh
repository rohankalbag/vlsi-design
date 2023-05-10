echo "generating random testcases"
python testcase_generator.py
echo "testcases primed"

echo "starting testing"
ghdl -a gates.vhdl
ghdl -e andgate
ghdl -e xorgate
ghdl -e abcgate

ghdl -a brent_kung_adder.vhdl
ghdl -e brentkung

ghdl -a testbench.vhdl
ghdl -e tb
ghdl -r tb --wave=wave.ghw
echo "testing completed"