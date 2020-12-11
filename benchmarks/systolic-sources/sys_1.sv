/* verilator lint_off WIDTH */
module std_reg
  #(parameter width = 32)
   (input wire [width-1:0] in,
    input wire write_en,
    input wire clk,
    // output
    output logic [width - 1:0] out,
    output logic done);

  always_ff @(posedge clk) begin
    if (write_en) begin
      out <= in;
      done <= 1'd1;
    end else
      done <= 1'd0;
  end
endmodule

module std_add
  #(parameter width = 32)
  (input  logic [width-1:0] left,
    input  logic [width-1:0] right,
    output logic [width-1:0] out);
  assign out = left + right;
endmodule

module std_mult_pipe
  #(parameter width = 32)
   (input logic [width-1:0] left,
    input logic [width-1:0] right,
    input logic go,
    input logic clk,
    output logic [width-1:0] out,
    output logic done);
   logic [width-1:0] rtmp;
   logic [width-1:0] ltmp;
   logic [width-1:0] out_tmp;
   reg done_buf[1:0];
   always_ff @(posedge clk) begin
     if (go) begin
       rtmp <= right;
       ltmp <= left;
       out_tmp <= rtmp * ltmp;
       out <= out_tmp;

       done <= done_buf[1];
       done_buf[0] <= 1'b1;
       done_buf[1] <= done_buf[0];
     end else begin
       rtmp <= 0;
       ltmp <= 0;
       out_tmp <= 0;
       out <= 0;

       done <= 0;
       done_buf[0] <= 0;
       done_buf[1] <= 0;
     end
   end
 endmodule

module std_mem_d1
  #(parameter width = 32,
    parameter size = 16,
    parameter idx_size = 4)
   (input logic [idx_size-1:0] addr0,
    input logic [width-1:0]   write_data,
    input logic               write_en,
    input logic               clk,
    output logic [width-1:0]  read_data,
    output logic done);

  logic [width-1:0]  mem[size-1:0];

  assign read_data = mem[addr0];
  always_ff @(posedge clk) begin
    if (write_en) begin
      mem[addr0] <= write_data;
      done <= 1'd1;
    end else
      done <= 1'd0;
  end
endmodule

// Component Signature
module mac_pe (
      input wire [31:0] top,
      input wire [31:0] left,
      input wire go,
      input wire clk,
      output wire [31:0] down,
      output wire [31:0] right,
      output wire [31:0] out,
      output wire done
  );
  
  // Structure wire declarations
  wire [31:0] mul_left;
  wire [31:0] mul_right;
  wire mul_go;
  wire mul_clk;
  wire [31:0] mul_out;
  wire mul_done;
  wire [31:0] add_left;
  wire [31:0] add_right;
  wire [31:0] add_out;
  wire [31:0] mul_reg_in;
  wire mul_reg_write_en;
  wire mul_reg_clk;
  wire [31:0] mul_reg_out;
  wire mul_reg_done;
  wire [31:0] acc_in;
  wire acc_write_en;
  wire acc_clk;
  wire [31:0] acc_out;
  wire acc_done;
  wire [31:0] fsm0_in;
  wire fsm0_write_en;
  wire fsm0_clk;
  wire [31:0] fsm0_out;
  wire fsm0_done;
  
  // Subcomponent Instances
  std_mult_pipe #(32) mul (
      .left(mul_left),
      .right(mul_right),
      .go(mul_go),
      .clk(clk),
      .out(mul_out),
      .done(mul_done)
  );
  
  std_add #(32) add (
      .left(add_left),
      .right(add_right),
      .out(add_out)
  );
  
  std_reg #(32) mul_reg (
      .in(mul_reg_in),
      .write_en(mul_reg_write_en),
      .clk(clk),
      .out(mul_reg_out),
      .done(mul_reg_done)
  );
  
  std_reg #(32) acc (
      .in(acc_in),
      .write_en(acc_write_en),
      .clk(clk),
      .out(acc_out),
      .done(acc_done)
  );
  
  std_reg #(32) fsm0 (
      .in(fsm0_in),
      .write_en(fsm0_write_en),
      .clk(clk),
      .out(fsm0_out),
      .done(fsm0_done)
  );
  
  // Input / output connections
  assign down = top;
  assign right = left;
  assign out = acc_out;
  assign done = (fsm0_out == 32'd2) ? 1'd1 : '0;
  assign mul_left = (fsm0_out == 32'd0 & !mul_reg_done & go) ? top : '0;
  assign mul_right = (fsm0_out == 32'd0 & !mul_reg_done & go) ? left : '0;
  assign mul_go = (!mul_done & fsm0_out == 32'd0 & !mul_reg_done & go) ? 1'd1 : '0;
  assign add_left = (fsm0_out == 32'd1 & !acc_done & go) ? acc_out : '0;
  assign add_right = (fsm0_out == 32'd1 & !acc_done & go) ? mul_reg_out : '0;
  assign mul_reg_in = (mul_done & fsm0_out == 32'd0 & !mul_reg_done & go) ? mul_out : '0;
  assign mul_reg_write_en = (mul_done & fsm0_out == 32'd0 & !mul_reg_done & go) ? 1'd1 : '0;
  assign acc_in = (fsm0_out == 32'd1 & !acc_done & go) ? add_out : '0;
  assign acc_write_en = (fsm0_out == 32'd1 & !acc_done & go) ? 1'd1 : '0;
  assign fsm0_in = (fsm0_out == 32'd1 & acc_done & go) ? 32'd2 : (fsm0_out == 32'd0 & mul_reg_done & go) ? 32'd1 : (fsm0_out == 32'd2) ? 32'd0 : '0;
  assign fsm0_write_en = (fsm0_out == 32'd0 & mul_reg_done & go | fsm0_out == 32'd1 & acc_done & go | fsm0_out == 32'd2) ? 1'd1 : '0;
endmodule // end mac_pe
// Component Signature
module main (
      input wire go,
      input wire clk,
      input wire [31:0] out_mem_read_data,
      input wire out_mem_done,
      output wire done,
      output wire out_mem_addr0,
      output wire out_mem_addr1,
      output wire [31:0] out_mem_write_data,
      output wire out_mem_write_en
  );
  
  // Structure wire declarations
  wire [31:0] left_00_read_in;
  wire left_00_read_write_en;
  wire left_00_read_clk;
  wire [31:0] left_00_read_out;
  wire left_00_read_done;
  wire [31:0] top_00_read_in;
  wire top_00_read_write_en;
  wire top_00_read_clk;
  wire [31:0] top_00_read_out;
  wire top_00_read_done;
  wire [31:0] pe_00_top;
  wire [31:0] pe_00_left;
  wire pe_00_go;
  wire pe_00_clk;
  wire [31:0] pe_00_down;
  wire [31:0] pe_00_right;
  wire [31:0] pe_00_out;
  wire pe_00_done;
  wire l0_addr0;
  wire [31:0] l0_write_data;
  wire l0_write_en;
  wire l0_clk;
  wire [31:0] l0_read_data;
  wire l0_done;
  wire l0_add_left;
  wire l0_add_right;
  wire l0_add_out;
  wire l0_idx_in;
  wire l0_idx_write_en;
  wire l0_idx_clk;
  wire l0_idx_out;
  wire l0_idx_done;
  wire t0_addr0;
  wire [31:0] t0_write_data;
  wire t0_write_en;
  wire t0_clk;
  wire [31:0] t0_read_data;
  wire t0_done;
  wire t0_add_left;
  wire t0_add_right;
  wire t0_add_out;
  wire t0_idx_in;
  wire t0_idx_write_en;
  wire t0_idx_clk;
  wire t0_idx_out;
  wire t0_idx_done;
  wire par_reset0_in;
  wire par_reset0_write_en;
  wire par_reset0_clk;
  wire par_reset0_out;
  wire par_reset0_done;
  wire par_done_reg0_in;
  wire par_done_reg0_write_en;
  wire par_done_reg0_clk;
  wire par_done_reg0_out;
  wire par_done_reg0_done;
  wire par_done_reg1_in;
  wire par_done_reg1_write_en;
  wire par_done_reg1_clk;
  wire par_done_reg1_out;
  wire par_done_reg1_done;
  wire par_reset1_in;
  wire par_reset1_write_en;
  wire par_reset1_clk;
  wire par_reset1_out;
  wire par_reset1_done;
  wire par_done_reg2_in;
  wire par_done_reg2_write_en;
  wire par_done_reg2_clk;
  wire par_done_reg2_out;
  wire par_done_reg2_done;
  wire par_done_reg3_in;
  wire par_done_reg3_write_en;
  wire par_done_reg3_clk;
  wire par_done_reg3_out;
  wire par_done_reg3_done;
  wire par_reset2_in;
  wire par_reset2_write_en;
  wire par_reset2_clk;
  wire par_reset2_out;
  wire par_reset2_done;
  wire par_done_reg4_in;
  wire par_done_reg4_write_en;
  wire par_done_reg4_clk;
  wire par_done_reg4_out;
  wire par_done_reg4_done;
  wire par_done_reg5_in;
  wire par_done_reg5_write_en;
  wire par_done_reg5_clk;
  wire par_done_reg5_out;
  wire par_done_reg5_done;
  wire par_reset3_in;
  wire par_reset3_write_en;
  wire par_reset3_clk;
  wire par_reset3_out;
  wire par_reset3_done;
  wire par_done_reg6_in;
  wire par_done_reg6_write_en;
  wire par_done_reg6_clk;
  wire par_done_reg6_out;
  wire par_done_reg6_done;
  wire [31:0] fsm0_in;
  wire fsm0_write_en;
  wire fsm0_clk;
  wire [31:0] fsm0_out;
  wire fsm0_done;
  
  // Subcomponent Instances
  std_reg #(32) left_00_read (
      .in(left_00_read_in),
      .write_en(left_00_read_write_en),
      .clk(clk),
      .out(left_00_read_out),
      .done(left_00_read_done)
  );
  
  std_reg #(32) top_00_read (
      .in(top_00_read_in),
      .write_en(top_00_read_write_en),
      .clk(clk),
      .out(top_00_read_out),
      .done(top_00_read_done)
  );
  
  mac_pe #() pe_00 (
      .top(pe_00_top),
      .left(pe_00_left),
      .go(pe_00_go),
      .clk(clk),
      .down(pe_00_down),
      .right(pe_00_right),
      .out(pe_00_out),
      .done(pe_00_done)
  );
  
  std_mem_d1 #(32, 1, 1) l0 (
      .addr0(l0_addr0),
      .write_data(l0_write_data),
      .write_en(l0_write_en),
      .clk(clk),
      .read_data(l0_read_data),
      .done(l0_done)
  );
  
  std_add #(1) l0_add (
      .left(l0_add_left),
      .right(l0_add_right),
      .out(l0_add_out)
  );
  
  std_reg #(1) l0_idx (
      .in(l0_idx_in),
      .write_en(l0_idx_write_en),
      .clk(clk),
      .out(l0_idx_out),
      .done(l0_idx_done)
  );
  
  std_mem_d1 #(32, 1, 1) t0 (
      .addr0(t0_addr0),
      .write_data(t0_write_data),
      .write_en(t0_write_en),
      .clk(clk),
      .read_data(t0_read_data),
      .done(t0_done)
  );
  
  std_add #(1) t0_add (
      .left(t0_add_left),
      .right(t0_add_right),
      .out(t0_add_out)
  );
  
  std_reg #(1) t0_idx (
      .in(t0_idx_in),
      .write_en(t0_idx_write_en),
      .clk(clk),
      .out(t0_idx_out),
      .done(t0_idx_done)
  );
  
  std_reg #(1) par_reset0 (
      .in(par_reset0_in),
      .write_en(par_reset0_write_en),
      .clk(clk),
      .out(par_reset0_out),
      .done(par_reset0_done)
  );
  
  std_reg #(1) par_done_reg0 (
      .in(par_done_reg0_in),
      .write_en(par_done_reg0_write_en),
      .clk(clk),
      .out(par_done_reg0_out),
      .done(par_done_reg0_done)
  );
  
  std_reg #(1) par_done_reg1 (
      .in(par_done_reg1_in),
      .write_en(par_done_reg1_write_en),
      .clk(clk),
      .out(par_done_reg1_out),
      .done(par_done_reg1_done)
  );
  
  std_reg #(1) par_reset1 (
      .in(par_reset1_in),
      .write_en(par_reset1_write_en),
      .clk(clk),
      .out(par_reset1_out),
      .done(par_reset1_done)
  );
  
  std_reg #(1) par_done_reg2 (
      .in(par_done_reg2_in),
      .write_en(par_done_reg2_write_en),
      .clk(clk),
      .out(par_done_reg2_out),
      .done(par_done_reg2_done)
  );
  
  std_reg #(1) par_done_reg3 (
      .in(par_done_reg3_in),
      .write_en(par_done_reg3_write_en),
      .clk(clk),
      .out(par_done_reg3_out),
      .done(par_done_reg3_done)
  );
  
  std_reg #(1) par_reset2 (
      .in(par_reset2_in),
      .write_en(par_reset2_write_en),
      .clk(clk),
      .out(par_reset2_out),
      .done(par_reset2_done)
  );
  
  std_reg #(1) par_done_reg4 (
      .in(par_done_reg4_in),
      .write_en(par_done_reg4_write_en),
      .clk(clk),
      .out(par_done_reg4_out),
      .done(par_done_reg4_done)
  );
  
  std_reg #(1) par_done_reg5 (
      .in(par_done_reg5_in),
      .write_en(par_done_reg5_write_en),
      .clk(clk),
      .out(par_done_reg5_out),
      .done(par_done_reg5_done)
  );
  
  std_reg #(1) par_reset3 (
      .in(par_reset3_in),
      .write_en(par_reset3_write_en),
      .clk(clk),
      .out(par_reset3_out),
      .done(par_reset3_done)
  );
  
  std_reg #(1) par_done_reg6 (
      .in(par_done_reg6_in),
      .write_en(par_done_reg6_write_en),
      .clk(clk),
      .out(par_done_reg6_out),
      .done(par_done_reg6_done)
  );
  
  std_reg #(32) fsm0 (
      .in(fsm0_in),
      .write_en(fsm0_write_en),
      .clk(clk),
      .out(fsm0_out),
      .done(fsm0_done)
  );
  
  // Input / output connections
  assign done = (fsm0_out == 32'd5) ? 1'd1 : '0;
  assign out_mem_addr0 = (fsm0_out == 32'd4 & !out_mem_done & go) ? 1'd0 : '0;
  assign out_mem_addr1 = (fsm0_out == 32'd4 & !out_mem_done & go) ? 1'd0 : '0;
  assign out_mem_write_data = (fsm0_out == 32'd4 & !out_mem_done & go) ? pe_00_out : '0;
  assign out_mem_write_en = (fsm0_out == 32'd4 & !out_mem_done & go) ? 1'd1 : '0;
  assign left_00_read_in = (!(par_done_reg5_out | left_00_read_done) & fsm0_out == 32'd2 & !par_reset2_out & go) ? l0_read_data : '0;
  assign left_00_read_write_en = (!(par_done_reg5_out | left_00_read_done) & fsm0_out == 32'd2 & !par_reset2_out & go) ? 1'd1 : '0;
  assign top_00_read_in = (!(par_done_reg4_out | top_00_read_done) & fsm0_out == 32'd2 & !par_reset2_out & go) ? t0_read_data : '0;
  assign top_00_read_write_en = (!(par_done_reg4_out | top_00_read_done) & fsm0_out == 32'd2 & !par_reset2_out & go) ? 1'd1 : '0;
  assign pe_00_top = (!(par_done_reg6_out | pe_00_done) & fsm0_out == 32'd3 & !par_reset3_out & go) ? top_00_read_out : '0;
  assign pe_00_left = (!(par_done_reg6_out | pe_00_done) & fsm0_out == 32'd3 & !par_reset3_out & go) ? left_00_read_out : '0;
  assign pe_00_go = (!pe_00_done & !(par_done_reg6_out | pe_00_done) & fsm0_out == 32'd3 & !par_reset3_out & go) ? 1'd1 : '0;
  assign l0_addr0 = (!(par_done_reg5_out | left_00_read_done) & fsm0_out == 32'd2 & !par_reset2_out & go) ? l0_idx_out : '0;
  assign l0_add_left = (!(par_done_reg3_out | l0_idx_done) & fsm0_out == 32'd1 & !par_reset1_out & go) ? 1'd1 : '0;
  assign l0_add_right = (!(par_done_reg3_out | l0_idx_done) & fsm0_out == 32'd1 & !par_reset1_out & go) ? l0_idx_out : '0;
  assign l0_idx_in = (!(par_done_reg3_out | l0_idx_done) & fsm0_out == 32'd1 & !par_reset1_out & go) ? l0_add_out : (!(par_done_reg1_out | l0_idx_done) & fsm0_out == 32'd0 & !par_reset0_out & go) ? 1'd1 : '0;
  assign l0_idx_write_en = (!(par_done_reg1_out | l0_idx_done) & fsm0_out == 32'd0 & !par_reset0_out & go | !(par_done_reg3_out | l0_idx_done) & fsm0_out == 32'd1 & !par_reset1_out & go) ? 1'd1 : '0;
  assign t0_addr0 = (!(par_done_reg4_out | top_00_read_done) & fsm0_out == 32'd2 & !par_reset2_out & go) ? t0_idx_out : '0;
  assign t0_add_left = (!(par_done_reg2_out | t0_idx_done) & fsm0_out == 32'd1 & !par_reset1_out & go) ? 1'd1 : '0;
  assign t0_add_right = (!(par_done_reg2_out | t0_idx_done) & fsm0_out == 32'd1 & !par_reset1_out & go) ? t0_idx_out : '0;
  assign t0_idx_in = (!(par_done_reg2_out | t0_idx_done) & fsm0_out == 32'd1 & !par_reset1_out & go) ? t0_add_out : (!(par_done_reg0_out | t0_idx_done) & fsm0_out == 32'd0 & !par_reset0_out & go) ? 1'd1 : '0;
  assign t0_idx_write_en = (!(par_done_reg0_out | t0_idx_done) & fsm0_out == 32'd0 & !par_reset0_out & go | !(par_done_reg2_out | t0_idx_done) & fsm0_out == 32'd1 & !par_reset1_out & go) ? 1'd1 : '0;
  assign par_reset0_in = par_reset0_out ? 1'd0 : (par_done_reg0_out & par_done_reg1_out & fsm0_out == 32'd0 & !par_reset0_out & go) ? 1'd1 : '0;
  assign par_reset0_write_en = (par_done_reg0_out & par_done_reg1_out & fsm0_out == 32'd0 & !par_reset0_out & go | par_reset0_out) ? 1'd1 : '0;
  assign par_done_reg0_in = par_reset0_out ? 1'd0 : (t0_idx_done & fsm0_out == 32'd0 & !par_reset0_out & go) ? 1'd1 : '0;
  assign par_done_reg0_write_en = (t0_idx_done & fsm0_out == 32'd0 & !par_reset0_out & go | par_reset0_out) ? 1'd1 : '0;
  assign par_done_reg1_in = par_reset0_out ? 1'd0 : (l0_idx_done & fsm0_out == 32'd0 & !par_reset0_out & go) ? 1'd1 : '0;
  assign par_done_reg1_write_en = (l0_idx_done & fsm0_out == 32'd0 & !par_reset0_out & go | par_reset0_out) ? 1'd1 : '0;
  assign par_reset1_in = par_reset1_out ? 1'd0 : (par_done_reg2_out & par_done_reg3_out & fsm0_out == 32'd1 & !par_reset1_out & go) ? 1'd1 : '0;
  assign par_reset1_write_en = (par_done_reg2_out & par_done_reg3_out & fsm0_out == 32'd1 & !par_reset1_out & go | par_reset1_out) ? 1'd1 : '0;
  assign par_done_reg2_in = par_reset1_out ? 1'd0 : (t0_idx_done & fsm0_out == 32'd1 & !par_reset1_out & go) ? 1'd1 : '0;
  assign par_done_reg2_write_en = (t0_idx_done & fsm0_out == 32'd1 & !par_reset1_out & go | par_reset1_out) ? 1'd1 : '0;
  assign par_done_reg3_in = par_reset1_out ? 1'd0 : (l0_idx_done & fsm0_out == 32'd1 & !par_reset1_out & go) ? 1'd1 : '0;
  assign par_done_reg3_write_en = (l0_idx_done & fsm0_out == 32'd1 & !par_reset1_out & go | par_reset1_out) ? 1'd1 : '0;
  assign par_reset2_in = par_reset2_out ? 1'd0 : (par_done_reg4_out & par_done_reg5_out & fsm0_out == 32'd2 & !par_reset2_out & go) ? 1'd1 : '0;
  assign par_reset2_write_en = (par_done_reg4_out & par_done_reg5_out & fsm0_out == 32'd2 & !par_reset2_out & go | par_reset2_out) ? 1'd1 : '0;
  assign par_done_reg4_in = par_reset2_out ? 1'd0 : (top_00_read_done & fsm0_out == 32'd2 & !par_reset2_out & go) ? 1'd1 : '0;
  assign par_done_reg4_write_en = (top_00_read_done & fsm0_out == 32'd2 & !par_reset2_out & go | par_reset2_out) ? 1'd1 : '0;
  assign par_done_reg5_in = par_reset2_out ? 1'd0 : (left_00_read_done & fsm0_out == 32'd2 & !par_reset2_out & go) ? 1'd1 : '0;
  assign par_done_reg5_write_en = (left_00_read_done & fsm0_out == 32'd2 & !par_reset2_out & go | par_reset2_out) ? 1'd1 : '0;
  assign par_reset3_in = par_reset3_out ? 1'd0 : (par_done_reg6_out & fsm0_out == 32'd3 & !par_reset3_out & go) ? 1'd1 : '0;
  assign par_reset3_write_en = (par_done_reg6_out & fsm0_out == 32'd3 & !par_reset3_out & go | par_reset3_out) ? 1'd1 : '0;
  assign par_done_reg6_in = par_reset3_out ? 1'd0 : (pe_00_done & fsm0_out == 32'd3 & !par_reset3_out & go) ? 1'd1 : '0;
  assign par_done_reg6_write_en = (pe_00_done & fsm0_out == 32'd3 & !par_reset3_out & go | par_reset3_out) ? 1'd1 : '0;
  assign fsm0_in = (fsm0_out == 32'd4 & out_mem_done & go) ? 32'd5 : (fsm0_out == 32'd3 & par_reset3_out & go) ? 32'd4 : (fsm0_out == 32'd2 & par_reset2_out & go) ? 32'd3 : (fsm0_out == 32'd1 & par_reset1_out & go) ? 32'd2 : (fsm0_out == 32'd0 & par_reset0_out & go) ? 32'd1 : (fsm0_out == 32'd5) ? 32'd0 : '0;
  assign fsm0_write_en = (fsm0_out == 32'd0 & par_reset0_out & go | fsm0_out == 32'd1 & par_reset1_out & go | fsm0_out == 32'd2 & par_reset2_out & go | fsm0_out == 32'd3 & par_reset3_out & go | fsm0_out == 32'd4 & out_mem_done & go | fsm0_out == 32'd5) ? 1'd1 : '0;
endmodule // end main