// git.status = dirty, build.date = Wed Nov 04 19:48:43 EST 2020, git.hash = 497eae8
#include <ap_int.h>
extern "C" {
  void kernel(ap_uint<32> alpha_int[1], ap_uint<32> beta_int[1], ap_uint<32> A_int[64][64], ap_uint<32> u1_int[64], ap_uint<32> v1_int[64], ap_uint<32> u2_int[64], ap_uint<32> v2_int[64], ap_uint<32> w_int[64], ap_uint<32> x_int[64], ap_uint<32> y_int[64], ap_uint<32> z_int[64]) {
    #pragma HLS INTERFACE m_axi port=alpha_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=alpha_int bundle=control
    #pragma HLS INTERFACE m_axi port=beta_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=beta_int bundle=control
    #pragma HLS INTERFACE m_axi port=A_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=A_int bundle=control
    #pragma HLS INTERFACE m_axi port=u1_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=u1_int bundle=control
    #pragma HLS INTERFACE m_axi port=v1_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=v1_int bundle=control
    #pragma HLS INTERFACE m_axi port=u2_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=u2_int bundle=control
    #pragma HLS INTERFACE m_axi port=v2_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=v2_int bundle=control
    #pragma HLS INTERFACE m_axi port=w_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=w_int bundle=control
    #pragma HLS INTERFACE m_axi port=x_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=x_int bundle=control
    #pragma HLS INTERFACE m_axi port=y_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=y_int bundle=control
    #pragma HLS INTERFACE m_axi port=z_int offset=slave bundle=gmem
    #pragma HLS INTERFACE s_axilite port=z_int bundle=control
    #pragma HLS INTERFACE s_axilite port=return bundle=control
    ap_uint<32> A[64][64];
    #pragma HLS resource variable=A core=RAM_1P_BRAM
    ap_uint<32> u1[64];
    #pragma HLS resource variable=u1 core=RAM_1P_BRAM
    ap_uint<32> v1[64];
    #pragma HLS resource variable=v1 core=RAM_1P_BRAM
    ap_uint<32> u2[64];
    #pragma HLS resource variable=u2 core=RAM_1P_BRAM
    ap_uint<32> v2[64];
    #pragma HLS resource variable=v2 core=RAM_1P_BRAM
    ap_uint<32> w[64];
    #pragma HLS resource variable=w core=RAM_1P_BRAM
    ap_uint<32> x[64];
    #pragma HLS resource variable=x core=RAM_1P_BRAM
    ap_uint<32> y[64];
    #pragma HLS resource variable=y core=RAM_1P_BRAM
    ap_uint<32> z[64];
    #pragma HLS resource variable=z core=RAM_1P_BRAM
    ap_uint<32> alpha_ = alpha_int[0];
    ap_uint<32> beta_ = beta_int[0];
    for(int i = 0; i < 64; i++) {
      #pragma HLS UNROLL factor=1 skip_exit_check
      #pragma HLS LOOP_FLATTEN off
      u1[i] = u1_int[i];
      v1[i] = v1_int[i];
      u2[i] = u2_int[i];
      v2[i] = v2_int[i];
      w[i] = w_int[i];
      x[i] = x_int[i];
      y[i] = y_int[i];
      z[i] = z_int[i];
    }
    for(int i = 0; i < 64; i++) {
      #pragma HLS UNROLL factor=1 skip_exit_check
      #pragma HLS LOOP_FLATTEN off
      for(int j = 0; j < 64; j++) {
        #pragma HLS UNROLL factor=1 skip_exit_check
        #pragma HLS LOOP_FLATTEN off
        A[i][j] = A_int[i][j];
      }
    }
    //---
    for(int i = 0; i < 64; i++) {
      #pragma HLS UNROLL factor=1 skip_exit_check
      #pragma HLS LOOP_FLATTEN off
      for(int j = 0; j < 64; j++) {
        #pragma HLS UNROLL factor=1 skip_exit_check
        #pragma HLS LOOP_FLATTEN off
        ap_uint<32> tmp1 = ((u1[i] * v1[j]) + (u2[i] * v2[j]));
        ap_uint<32> old = A[i][j];
        //---
        A[i][j] = (old + tmp1);
      }
    }
    //---
    for(int i = 0; i < 64; i++) {
      #pragma HLS UNROLL factor=1 skip_exit_check
      #pragma HLS LOOP_FLATTEN off
      for(int j = 0; j < 64; j++) {
        #pragma HLS UNROLL factor=1 skip_exit_check
        #pragma HLS LOOP_FLATTEN off
        ap_uint<32> tmp2 = ((beta_ * A[j][i]) * y[j]);
        // combiner:
        x[i] += tmp2;
      }
    }
    //---
    for(int i = 0; i < 64; i++) {
      #pragma HLS UNROLL factor=1 skip_exit_check
      #pragma HLS LOOP_FLATTEN off
      ap_uint<32> tmp3 = z[i];
      ap_uint<32> old = x[i];
      //---
      x[i] = (old + tmp3);
    }
    //---
    for(int i = 0; i < 64; i++) {
      #pragma HLS UNROLL factor=1 skip_exit_check
      #pragma HLS LOOP_FLATTEN off
      for(int j = 0; j < 64; j++) {
        #pragma HLS UNROLL factor=1 skip_exit_check
        #pragma HLS LOOP_FLATTEN off
        ap_uint<32> tmp4 = ((alpha_ * A[i][j]) * x[j]);
        // combiner:
        w[i] += tmp4;
      }
    }
    //---
    for(int i = 0; i < 64; i++) {
      #pragma HLS UNROLL factor=1 skip_exit_check
      #pragma HLS LOOP_FLATTEN off
      u1_int[i] = u1[i];
      v1_int[i] = v1[i];
      u2_int[i] = u2[i];
      v2_int[i] = v2[i];
      w_int[i] = w[i];
      x_int[i] = x[i];
      y_int[i] = y[i];
      z_int[i] = z[i];
    }
    for(int i = 0; i < 64; i++) {
      #pragma HLS UNROLL factor=1 skip_exit_check
      #pragma HLS LOOP_FLATTEN off
      for(int j = 0; j < 64; j++) {
        #pragma HLS UNROLL factor=1 skip_exit_check
        #pragma HLS LOOP_FLATTEN off
        A_int[i][j] = A[i][j];
      }
    }
  }
}
