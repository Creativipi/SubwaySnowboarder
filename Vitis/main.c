#include "scaler.h"
#include "vdma.h"
#include "xil_printf.h"
#include "myColorRegister.h"
#include "sleep.h"

int main()
{
	configureScaler();
    configureVdma();

    int viewPortOffset = 0;
    int n = 0;
	// Mask x and y to 10 bits in case of overflow (x=0 here)
    unsigned int x = 0 & 0x3FF;
    unsigned int y = 0;
    unsigned int instruction;

    while(1)
    {
		viewPortOffset = 64*n;
		y = viewPortOffset & 0x3FF;

		// Encode SetView instruction:
		// opcode[31:28] | zero[27:24] | x[23:14] | y[13:4] | zero[3:0]
		instruction = (0x1 << 28) | (x << 14) | (y << 4);
		MYCONTROLLERPPU_mWriteReg(XPAR_MYCONTROLLLERPPU_0_S00_AXI_BASEADDR, 0, instruction);
		n = (n+1)%9;
		sleep(1);
    }

    return 0;
}
