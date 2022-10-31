echo "generating random testcases"
python testcase_generator.py
echo "testcases primed"

echo "starting testing"
ghdl -a gates.vhdl
ghdl -e andgate
ghdl -e xorgate
ghdl -e abcgate
ghdl -e Cin_map_G

ghdl -a adders.vhdl
ghdl -e brentkung
ghdl -e fa
ghdl -e ha

ghdl -a mac.vhdl
ghdl -e multiply_accumulate

ghdl -a testbench.vhdl
ghdl -e tb
ghdl -r tb --wave=wave.ghw
echo "testing completed"