#include "VTest_PP_16.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main() {
    Verilated::traceEverOn(true);

    VTest_PP_16* top = new VTest_PP_16;

    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("Test_PP_16.vcd");

    while (!Verilated::gotFinish()) {
        top->eval();
        tfp->dump(Verilated::time());
        Verilated::timeInc(1);  
    }

    tfp->close();
    delete top;
    return 0;
}