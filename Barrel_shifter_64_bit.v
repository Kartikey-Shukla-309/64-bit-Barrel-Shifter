`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2025 10:45:40
// Design Name: 
// Module Name: Barrel_shifter_64_bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Barrel_shifter_64_bit(
input [63:0] d_in,    // input data
input [5:0] sh_amt,   // shift amount
input dir,type,       // dir = 0 : left, dir = 1 : right. type = 0 : logic, type = 1 : arithmetic
output [63:0] d_out,  // output data
output z              // Zero flag
    );
    
    wire [63:0] l0,l1,l2,l3,l4,l5;  // left shifted values
    wire [63:0] r0,r1,r2,r3,r4,r5;  // right shifted values
    
    // right shift 
    assign r5 = (sh_amt[5]) ? {{32{d_in[63] & type}}, d_in[63:32]} : d_in;
    assign r4 = (sh_amt[4]) ? {{16{r5[63] & type}}, r5[63:16]} : r5;
    assign r3 = (sh_amt[3]) ? {{8{r4[63] & type}}, r4[63:8]} : r4;
    assign r2 = (sh_amt[2]) ? {{4{r3[63] & type}}, r3[63:4]} : r3;
    assign r1 = (sh_amt[1]) ? {{2{r2[63] & type}}, r2[63:2]} : r2;
    assign r0 = (sh_amt[0]) ? {{1{r1[63] & type}}, r1[63:1]} : r1;
    
    // left shift
    assign l5 = (sh_amt[5]) ? {d_in[31:0],{32{1'b0}}} : d_in;
    assign l4 = (sh_amt[4]) ? {l5[47:0],{16{1'b0}}} : l5;
    assign l3 = (sh_amt[3]) ? {l4[55:0],{8{1'b0}}} : l4;
    assign l2 = (sh_amt[2]) ? {l3[59:0],{4{1'b0}}} : l3;
    assign l1 = (sh_amt[1]) ? {l2[61:0],{2{1'b0}}} : l2;
    assign l0 = (sh_amt[0]) ? {l1[62:0],{1{1'b0}}} : l1;
    
    // Final output
    assign d_out = (dir) ? r0 : l0;
    
    // Flags
    assign z = (d_out == 0) ? 1'b1 : 1'b0;
endmodule
