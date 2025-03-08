del sim.out dump.vcd
iverilog -g2005 -o sim.out code.v ./slv_module/code1.v
vvp -n sim.out
gtkwave dump.vcd
pause