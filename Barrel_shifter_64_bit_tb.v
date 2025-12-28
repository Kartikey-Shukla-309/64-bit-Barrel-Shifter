`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 16.12.2025 13:48:50
// Design Name: 
// Module Name: Barrel_shifter_64_bit_tb
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


module Barrel_shifter_64_bit_tb();
    reg  [63:0] d_in;
    reg  [5:0]  sh_amt;
    reg         dir;
    reg         type;

    wire [63:0] d_out;
    wire        z;

    // Instantiation
    Barrel_shifter_64_bit DUT (
        .d_in(d_in),
        .sh_amt(sh_amt),
        .dir(dir),
        .type(type),
        .d_out(d_out),
        .z(z)
    );

    initial begin
        $display("Time | dir type sh_amt | d_in -> d_out | z");
        $monitor("%4t |  %b    %b    %2d | %h -> %h | %b",
                 $time, dir, type, sh_amt, d_in, d_out, z);

        // -------- Test 1: Left logical shift --------
        d_in   = 64'h0000_0000_0000_0005;  // 5
        sh_amt = 3;
        dir    = 0;
        type   = 0;
        #10;

        // -------- Test 2: Right logical shift --------
        d_in   = 64'h0000_0000_0000_0020;  // 32
        sh_amt = 2;
        dir    = 1;
        type   = 0;
        #10;

        // -------- Test 3: Right arithmetic shift (negative) --------
        d_in   = 64'hFFFF_FFFF_FFFF_FFF0;  // -16
        sh_amt = 2;
        dir    = 1;
        type   = 1;
        #10;

        // -------- Test 4: Shift amount = 0 --------
        d_in   = 64'h1234_5678_9ABC_DEF0;
        sh_amt = 0;
        dir    = 0;
        type   = 0;
        #10;

        // -------- Test 5: Zero flag check --------
        d_in   = 64'h0000_0000_0000_0001;
        sh_amt = 1;
        dir    = 1;
        type   = 0;
        #10;

        // -------- Test 6: Max shift --------
        d_in   = 64'h8000_0000_0000_0000;
        sh_amt = 63;
        dir    = 1;
        type   = 1;
        #10;

        $finish;
    end
endmodule
