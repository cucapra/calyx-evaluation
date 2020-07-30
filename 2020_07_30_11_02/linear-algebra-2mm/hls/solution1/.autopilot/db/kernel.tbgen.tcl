set moduleName kernel
set isTopModule 1
set isTaskLevelControl 1
set isCombinational 0
set isDatapathOnly 0
set isFreeRunPipelineModule 0
set isPipelined 0
set pipeline_type none
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set C_modelName {kernel}
set C_modelType { void 0 }
set C_modelArgList {
	{ alpha_V int 32 regular {bram 1 { 1 3 } 1 1 }  }
	{ beta_V int 32 regular {bram 1 { 1 3 } 1 1 }  }
	{ tmp_V int 32 regular {bram 64 { 2 3 } 1 1 }  }
	{ A_V int 32 regular {bram 64 { 1 3 } 1 1 }  }
	{ B_V int 32 regular {bram 64 { 1 3 } 1 1 }  }
	{ C_V int 32 regular {bram 64 { 1 3 } 1 1 }  }
	{ D_V int 32 regular {bram 64 { 2 3 } 1 1 }  }
}
set C_modelArgMapList {[ 
	{ "Name" : "alpha_V", "interface" : "bram", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "alpha.V","cData": "uint32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}]} , 
 	{ "Name" : "beta_V", "interface" : "bram", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "beta.V","cData": "uint32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 0,"step" : 1}]}]}]} , 
 	{ "Name" : "tmp_V", "interface" : "bram", "bitwidth" : 32, "direction" : "READWRITE", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "tmp.V","cData": "uint32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 7,"step" : 1},{"low" : 0,"up" : 7,"step" : 1}]}]}]} , 
 	{ "Name" : "A_V", "interface" : "bram", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "A.V","cData": "uint32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 7,"step" : 1},{"low" : 0,"up" : 7,"step" : 1}]}]}]} , 
 	{ "Name" : "B_V", "interface" : "bram", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "B.V","cData": "uint32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 7,"step" : 1},{"low" : 0,"up" : 7,"step" : 1}]}]}]} , 
 	{ "Name" : "C_V", "interface" : "bram", "bitwidth" : 32, "direction" : "READONLY", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "C.V","cData": "uint32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 7,"step" : 1},{"low" : 0,"up" : 7,"step" : 1}]}]}]} , 
 	{ "Name" : "D_V", "interface" : "bram", "bitwidth" : 32, "direction" : "READWRITE", "bitSlice":[{"low":0,"up":31,"cElement": [{"cName": "D.V","cData": "uint32","bit_use": { "low": 0,"up": 31},"cArray": [{"low" : 0,"up" : 7,"step" : 1},{"low" : 0,"up" : 7,"step" : 1}]}]}]} ]}
# RTL Port declarations: 
set portNum 69
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst_n sc_in sc_logic 1 reset -1 active_low_sync } 
	{ alpha_V_Addr_A sc_out sc_lv 32 signal 0 } 
	{ alpha_V_EN_A sc_out sc_logic 1 signal 0 } 
	{ alpha_V_WEN_A sc_out sc_lv 4 signal 0 } 
	{ alpha_V_Din_A sc_out sc_lv 32 signal 0 } 
	{ alpha_V_Dout_A sc_in sc_lv 32 signal 0 } 
	{ alpha_V_Clk_A sc_out sc_logic 1 signal 0 } 
	{ alpha_V_Rst_A sc_out sc_logic 1 signal 0 } 
	{ beta_V_Addr_A sc_out sc_lv 32 signal 1 } 
	{ beta_V_EN_A sc_out sc_logic 1 signal 1 } 
	{ beta_V_WEN_A sc_out sc_lv 4 signal 1 } 
	{ beta_V_Din_A sc_out sc_lv 32 signal 1 } 
	{ beta_V_Dout_A sc_in sc_lv 32 signal 1 } 
	{ beta_V_Clk_A sc_out sc_logic 1 signal 1 } 
	{ beta_V_Rst_A sc_out sc_logic 1 signal 1 } 
	{ tmp_V_Addr_A sc_out sc_lv 32 signal 2 } 
	{ tmp_V_EN_A sc_out sc_logic 1 signal 2 } 
	{ tmp_V_WEN_A sc_out sc_lv 4 signal 2 } 
	{ tmp_V_Din_A sc_out sc_lv 32 signal 2 } 
	{ tmp_V_Dout_A sc_in sc_lv 32 signal 2 } 
	{ tmp_V_Clk_A sc_out sc_logic 1 signal 2 } 
	{ tmp_V_Rst_A sc_out sc_logic 1 signal 2 } 
	{ A_V_Addr_A sc_out sc_lv 32 signal 3 } 
	{ A_V_EN_A sc_out sc_logic 1 signal 3 } 
	{ A_V_WEN_A sc_out sc_lv 4 signal 3 } 
	{ A_V_Din_A sc_out sc_lv 32 signal 3 } 
	{ A_V_Dout_A sc_in sc_lv 32 signal 3 } 
	{ A_V_Clk_A sc_out sc_logic 1 signal 3 } 
	{ A_V_Rst_A sc_out sc_logic 1 signal 3 } 
	{ B_V_Addr_A sc_out sc_lv 32 signal 4 } 
	{ B_V_EN_A sc_out sc_logic 1 signal 4 } 
	{ B_V_WEN_A sc_out sc_lv 4 signal 4 } 
	{ B_V_Din_A sc_out sc_lv 32 signal 4 } 
	{ B_V_Dout_A sc_in sc_lv 32 signal 4 } 
	{ B_V_Clk_A sc_out sc_logic 1 signal 4 } 
	{ B_V_Rst_A sc_out sc_logic 1 signal 4 } 
	{ C_V_Addr_A sc_out sc_lv 32 signal 5 } 
	{ C_V_EN_A sc_out sc_logic 1 signal 5 } 
	{ C_V_WEN_A sc_out sc_lv 4 signal 5 } 
	{ C_V_Din_A sc_out sc_lv 32 signal 5 } 
	{ C_V_Dout_A sc_in sc_lv 32 signal 5 } 
	{ C_V_Clk_A sc_out sc_logic 1 signal 5 } 
	{ C_V_Rst_A sc_out sc_logic 1 signal 5 } 
	{ D_V_Addr_A sc_out sc_lv 32 signal 6 } 
	{ D_V_EN_A sc_out sc_logic 1 signal 6 } 
	{ D_V_WEN_A sc_out sc_lv 4 signal 6 } 
	{ D_V_Din_A sc_out sc_lv 32 signal 6 } 
	{ D_V_Dout_A sc_in sc_lv 32 signal 6 } 
	{ D_V_Clk_A sc_out sc_logic 1 signal 6 } 
	{ D_V_Rst_A sc_out sc_logic 1 signal 6 } 
	{ s_axi_control_AWVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_AWREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_AWADDR sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_WVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_WREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_WDATA sc_in sc_lv 32 signal -1 } 
	{ s_axi_control_WSTRB sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_ARVALID sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_ARREADY sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_ARADDR sc_in sc_lv 4 signal -1 } 
	{ s_axi_control_RVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_RREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_RDATA sc_out sc_lv 32 signal -1 } 
	{ s_axi_control_RRESP sc_out sc_lv 2 signal -1 } 
	{ s_axi_control_BVALID sc_out sc_logic 1 signal -1 } 
	{ s_axi_control_BREADY sc_in sc_logic 1 signal -1 } 
	{ s_axi_control_BRESP sc_out sc_lv 2 signal -1 } 
	{ interrupt sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "s_axi_control_AWADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "AWADDR" },"address":[{"name":"kernel","role":"start","value":"0","valid_bit":"0"},{"name":"kernel","role":"continue","value":"0","valid_bit":"4"},{"name":"kernel","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_AWVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWVALID" } },
	{ "name": "s_axi_control_AWREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "AWREADY" } },
	{ "name": "s_axi_control_WVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WVALID" } },
	{ "name": "s_axi_control_WREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "WREADY" } },
	{ "name": "s_axi_control_WDATA", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "WDATA" } },
	{ "name": "s_axi_control_WSTRB", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "WSTRB" } },
	{ "name": "s_axi_control_ARADDR", "direction": "in", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "control", "role": "ARADDR" },"address":[{"name":"kernel","role":"start","value":"0","valid_bit":"0"},{"name":"kernel","role":"done","value":"0","valid_bit":"1"},{"name":"kernel","role":"idle","value":"0","valid_bit":"2"},{"name":"kernel","role":"ready","value":"0","valid_bit":"3"},{"name":"kernel","role":"auto_start","value":"0","valid_bit":"7"}] },
	{ "name": "s_axi_control_ARVALID", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARVALID" } },
	{ "name": "s_axi_control_ARREADY", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "ARREADY" } },
	{ "name": "s_axi_control_RVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RVALID" } },
	{ "name": "s_axi_control_RREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "RREADY" } },
	{ "name": "s_axi_control_RDATA", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "control", "role": "RDATA" } },
	{ "name": "s_axi_control_RRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "RRESP" } },
	{ "name": "s_axi_control_BVALID", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BVALID" } },
	{ "name": "s_axi_control_BREADY", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "BREADY" } },
	{ "name": "s_axi_control_BRESP", "direction": "out", "datatype": "sc_lv", "bitwidth":2, "type": "signal", "bundle":{"name": "control", "role": "BRESP" } },
	{ "name": "interrupt", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "control", "role": "interrupt" } }, 
 	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst_n", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst_n", "role": "default" }} , 
 	{ "name": "alpha_V_Addr_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "alpha_V", "role": "Addr_A" }} , 
 	{ "name": "alpha_V_EN_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha_V", "role": "EN_A" }} , 
 	{ "name": "alpha_V_WEN_A", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "alpha_V", "role": "WEN_A" }} , 
 	{ "name": "alpha_V_Din_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "alpha_V", "role": "Din_A" }} , 
 	{ "name": "alpha_V_Dout_A", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "alpha_V", "role": "Dout_A" }} , 
 	{ "name": "alpha_V_Clk_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha_V", "role": "Clk_A" }} , 
 	{ "name": "alpha_V_Rst_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "alpha_V", "role": "Rst_A" }} , 
 	{ "name": "beta_V_Addr_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "beta_V", "role": "Addr_A" }} , 
 	{ "name": "beta_V_EN_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "beta_V", "role": "EN_A" }} , 
 	{ "name": "beta_V_WEN_A", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "beta_V", "role": "WEN_A" }} , 
 	{ "name": "beta_V_Din_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "beta_V", "role": "Din_A" }} , 
 	{ "name": "beta_V_Dout_A", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "beta_V", "role": "Dout_A" }} , 
 	{ "name": "beta_V_Clk_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "beta_V", "role": "Clk_A" }} , 
 	{ "name": "beta_V_Rst_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "beta_V", "role": "Rst_A" }} , 
 	{ "name": "tmp_V_Addr_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_V", "role": "Addr_A" }} , 
 	{ "name": "tmp_V_EN_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "tmp_V", "role": "EN_A" }} , 
 	{ "name": "tmp_V_WEN_A", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "tmp_V", "role": "WEN_A" }} , 
 	{ "name": "tmp_V_Din_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_V", "role": "Din_A" }} , 
 	{ "name": "tmp_V_Dout_A", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "tmp_V", "role": "Dout_A" }} , 
 	{ "name": "tmp_V_Clk_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "tmp_V", "role": "Clk_A" }} , 
 	{ "name": "tmp_V_Rst_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "tmp_V", "role": "Rst_A" }} , 
 	{ "name": "A_V_Addr_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_V", "role": "Addr_A" }} , 
 	{ "name": "A_V_EN_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_V", "role": "EN_A" }} , 
 	{ "name": "A_V_WEN_A", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "A_V", "role": "WEN_A" }} , 
 	{ "name": "A_V_Din_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_V", "role": "Din_A" }} , 
 	{ "name": "A_V_Dout_A", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "A_V", "role": "Dout_A" }} , 
 	{ "name": "A_V_Clk_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_V", "role": "Clk_A" }} , 
 	{ "name": "A_V_Rst_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "A_V", "role": "Rst_A" }} , 
 	{ "name": "B_V_Addr_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_V", "role": "Addr_A" }} , 
 	{ "name": "B_V_EN_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_V", "role": "EN_A" }} , 
 	{ "name": "B_V_WEN_A", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "B_V", "role": "WEN_A" }} , 
 	{ "name": "B_V_Din_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_V", "role": "Din_A" }} , 
 	{ "name": "B_V_Dout_A", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "B_V", "role": "Dout_A" }} , 
 	{ "name": "B_V_Clk_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_V", "role": "Clk_A" }} , 
 	{ "name": "B_V_Rst_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "B_V", "role": "Rst_A" }} , 
 	{ "name": "C_V_Addr_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_V", "role": "Addr_A" }} , 
 	{ "name": "C_V_EN_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_V", "role": "EN_A" }} , 
 	{ "name": "C_V_WEN_A", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "C_V", "role": "WEN_A" }} , 
 	{ "name": "C_V_Din_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_V", "role": "Din_A" }} , 
 	{ "name": "C_V_Dout_A", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "C_V", "role": "Dout_A" }} , 
 	{ "name": "C_V_Clk_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_V", "role": "Clk_A" }} , 
 	{ "name": "C_V_Rst_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "C_V", "role": "Rst_A" }} , 
 	{ "name": "D_V_Addr_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "D_V", "role": "Addr_A" }} , 
 	{ "name": "D_V_EN_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "D_V", "role": "EN_A" }} , 
 	{ "name": "D_V_WEN_A", "direction": "out", "datatype": "sc_lv", "bitwidth":4, "type": "signal", "bundle":{"name": "D_V", "role": "WEN_A" }} , 
 	{ "name": "D_V_Din_A", "direction": "out", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "D_V", "role": "Din_A" }} , 
 	{ "name": "D_V_Dout_A", "direction": "in", "datatype": "sc_lv", "bitwidth":32, "type": "signal", "bundle":{"name": "D_V", "role": "Dout_A" }} , 
 	{ "name": "D_V_Clk_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "D_V", "role": "Clk_A" }} , 
 	{ "name": "D_V_Rst_A", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "D_V", "role": "Rst_A" }}  ]}

set RtlHierarchyInfo {[
	{"ID" : "0", "Level" : "0", "Path" : "`AUTOTB_DUT_INST", "Parent" : "", "Child" : ["1", "2", "3", "4", "5"],
		"CDFG" : "kernel",
		"Protocol" : "ap_ctrl_hs",
		"ControlExist" : "1", "ap_start" : "1", "ap_ready" : "1", "ap_done" : "1", "ap_continue" : "0", "ap_idle" : "1",
		"Pipeline" : "None", "UnalignedPipeline" : "0", "RewindPipeline" : "0", "ProcessNetwork" : "0",
		"II" : "0",
		"VariableLatency" : "1", "ExactLatency" : "-1", "EstimateLatencyMin" : "8290", "EstimateLatencyMax" : "8290",
		"Combinational" : "0",
		"Datapath" : "0",
		"ClockEnable" : "0",
		"HasSubDataflow" : "0",
		"InDataflowNetwork" : "0",
		"HasNonBlockingOperation" : "0",
		"Port" : [
			{"Name" : "alpha_V", "Type" : "Bram", "Direction" : "I"},
			{"Name" : "beta_V", "Type" : "Bram", "Direction" : "I"},
			{"Name" : "tmp_V", "Type" : "Bram", "Direction" : "IO"},
			{"Name" : "A_V", "Type" : "Bram", "Direction" : "I"},
			{"Name" : "B_V", "Type" : "Bram", "Direction" : "I"},
			{"Name" : "C_V", "Type" : "Bram", "Direction" : "I"},
			{"Name" : "D_V", "Type" : "Bram", "Direction" : "IO"}]},
	{"ID" : "1", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.kernel_control_s_axi_U", "Parent" : "0"},
	{"ID" : "2", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.kernel_mul_32s_32s_32_3_1_U1", "Parent" : "0"},
	{"ID" : "3", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.kernel_mul_32s_32s_32_3_1_U2", "Parent" : "0"},
	{"ID" : "4", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.kernel_mul_32s_32s_32_3_1_U3", "Parent" : "0"},
	{"ID" : "5", "Level" : "1", "Path" : "`AUTOTB_DUT_INST.kernel_mul_32s_32s_32_3_1_U4", "Parent" : "0"}]}


set ArgLastReadFirstWriteLatency {
	kernel {
		alpha_V {Type I LastRead 6 FirstWrite -1}
		beta_V {Type I LastRead 3 FirstWrite -1}
		tmp_V {Type IO LastRead 9 FirstWrite 3}
		A_V {Type I LastRead 3 FirstWrite -1}
		B_V {Type I LastRead 3 FirstWrite -1}
		C_V {Type I LastRead 9 FirstWrite -1}
		D_V {Type IO LastRead 3 FirstWrite 9}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "8290", "Max" : "8290"}
	, {"Name" : "Interval", "Min" : "8291", "Max" : "8291"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	alpha_V { bram {  { alpha_V_Addr_A MemPortADDR2 1 32 }  { alpha_V_EN_A MemPortCE2 1 1 }  { alpha_V_WEN_A MemPortWE2 1 4 }  { alpha_V_Din_A MemPortDIN2 1 32 }  { alpha_V_Dout_A MemPortDOUT2 0 32 }  { alpha_V_Clk_A mem_clk 1 1 }  { alpha_V_Rst_A mem_rst 1 1 } } }
	beta_V { bram {  { beta_V_Addr_A MemPortADDR2 1 32 }  { beta_V_EN_A MemPortCE2 1 1 }  { beta_V_WEN_A MemPortWE2 1 4 }  { beta_V_Din_A MemPortDIN2 1 32 }  { beta_V_Dout_A MemPortDOUT2 0 32 }  { beta_V_Clk_A mem_clk 1 1 }  { beta_V_Rst_A mem_rst 1 1 } } }
	tmp_V { bram {  { tmp_V_Addr_A MemPortADDR2 1 32 }  { tmp_V_EN_A MemPortCE2 1 1 }  { tmp_V_WEN_A MemPortWE2 1 4 }  { tmp_V_Din_A MemPortDIN2 1 32 }  { tmp_V_Dout_A MemPortDOUT2 0 32 }  { tmp_V_Clk_A mem_clk 1 1 }  { tmp_V_Rst_A mem_rst 1 1 } } }
	A_V { bram {  { A_V_Addr_A MemPortADDR2 1 32 }  { A_V_EN_A MemPortCE2 1 1 }  { A_V_WEN_A MemPortWE2 1 4 }  { A_V_Din_A MemPortDIN2 1 32 }  { A_V_Dout_A MemPortDOUT2 0 32 }  { A_V_Clk_A mem_clk 1 1 }  { A_V_Rst_A mem_rst 1 1 } } }
	B_V { bram {  { B_V_Addr_A MemPortADDR2 1 32 }  { B_V_EN_A MemPortCE2 1 1 }  { B_V_WEN_A MemPortWE2 1 4 }  { B_V_Din_A MemPortDIN2 1 32 }  { B_V_Dout_A MemPortDOUT2 0 32 }  { B_V_Clk_A mem_clk 1 1 }  { B_V_Rst_A mem_rst 1 1 } } }
	C_V { bram {  { C_V_Addr_A MemPortADDR2 1 32 }  { C_V_EN_A MemPortCE2 1 1 }  { C_V_WEN_A MemPortWE2 1 4 }  { C_V_Din_A MemPortDIN2 1 32 }  { C_V_Dout_A MemPortDOUT2 0 32 }  { C_V_Clk_A mem_clk 1 1 }  { C_V_Rst_A mem_rst 1 1 } } }
	D_V { bram {  { D_V_Addr_A MemPortADDR2 1 32 }  { D_V_EN_A MemPortCE2 1 1 }  { D_V_WEN_A MemPortWE2 1 4 }  { D_V_Din_A MemPortDIN2 1 32 }  { D_V_Dout_A MemPortDOUT2 0 32 }  { D_V_Clk_A mem_clk 1 1 }  { D_V_Rst_A mem_rst 1 1 } } }
}

set busDeadlockParameterList { 
}

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
