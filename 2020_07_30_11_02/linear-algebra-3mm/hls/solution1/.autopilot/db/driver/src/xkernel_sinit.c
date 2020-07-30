// ==============================================================
// Vivado(TM) HLS - High-Level Synthesis from C, C++ and SystemC v2019.1 (64-bit)
// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xkernel.h"

extern XKernel_Config XKernel_ConfigTable[];

XKernel_Config *XKernel_LookupConfig(u16 DeviceId) {
	XKernel_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XKERNEL_NUM_INSTANCES; Index++) {
		if (XKernel_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XKernel_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XKernel_Initialize(XKernel *InstancePtr, u16 DeviceId) {
	XKernel_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XKernel_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XKernel_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

