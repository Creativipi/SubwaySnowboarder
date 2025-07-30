// #include "scaler.h"
// #include "vdma.h"
// #include "xil_printf.h"
// #include "myColorRegister.h"
// #include "sleep.h"

// int main() {
//     configureScaler();
//     configureVdma();

//     int viewPortOffset = 0;
//     int n = 0;
//     int frameCount = 0;
//     unsigned int x = 0 & 0x3FF;
//     unsigned int y = 0;
//     unsigned int instruction;

//     // Define actor position sequence
//     int actor_positions[3] = {
//         100,
//         200,
//         300
//     };
//     int i = 0;

//     while(1)
//     {
//         // Background scroll
//         viewPortOffset = 64 * n;
//         y = viewPortOffset & 0x3FF;

//         // Encode SetView instruction
//         instruction = (0x1 << 28) | (x << 14) | (y << 4);
//         MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, instruction);

//         // Every 300 frames, update actor position
//         if (frameCount % 300 == 0)
//         {
//             frameCount = 0;
//             int ax = actor_positions[i] & 0x3FF;
//             int ay = actor_positions[i] & 0x3FF;

//             instruction = (0x3 << 28) | (0x0 << 25) | (1 << 24) | (ax << 14) | (ay << 4);
//             MYCOLORREGISTER_mWriteReg(XPAR_MYCOLORREGISTER_0_S00_AXI_BASEADDR, 0, instruction);

//             i = (i + 1) % 3;
//         }

//         n = (n + 1) % 9;
//         frameCount++;
//         usleep(10000);
//     }

//     return 0;
// }
