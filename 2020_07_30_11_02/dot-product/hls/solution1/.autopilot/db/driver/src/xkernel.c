// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xkernel.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XKernel_CfgInitialize(XKernel *InstancePtr, XKernel_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XKernel_Start(XKernel *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_AP_CTRL) & 0x80;
    XKernel_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XKernel_IsDone(XKernel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XKernel_IsIdle(XKernel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XKernel_IsReady(XKernel *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XKernel_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XKernel_EnableAutoRestart(XKernel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XKernel_DisableAutoRestart(XKernel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_AP_CTRL, 0);
}

void XKernel_InterruptGlobalEnable(XKernel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_GIE, 1);
}

void XKernel_InterruptGlobalDisable(XKernel *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_GIE, 0);
}

void XKernel_InterruptEnable(XKernel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKernel_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_IER);
    XKernel_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_IER, Register | Mask);
}

void XKernel_InterruptDisable(XKernel *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XKernel_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_IER);
    XKernel_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_IER, Register & (~Mask));
}

void XKernel_InterruptClear(XKernel *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XKernel_WriteReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_ISR, Mask);
}

u32 XKernel_InterruptGetEnabled(XKernel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKernel_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_IER);
}

u32 XKernel_InterruptGetStatus(XKernel *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XKernel_ReadReg(InstancePtr->Control_BaseAddress, XKERNEL_CONTROL_ADDR_ISR);
}

