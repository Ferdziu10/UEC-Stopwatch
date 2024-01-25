`timescale 1ns / 1ps
/******************************************************************************
 * (C) Copyright 2023 AGH UST All Rights Reserved
 *
 * MODULE:    stopwatch
 * DEVICE:    xc7a35t_0 (BASYS3)
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  Simple stopwatch with start and stop buttons and LCD display
 *
 * HISTORY:
 * 4 Jan 2016, RS - initial version
 * 18 Jan 2023, LK - ported to SystemVerilog
 * 24 Jan 2024, KF - changed module clk_divider to top_clk_divider
 * 24 Jan 2024, KF - added bcd3 in u_bin and increased value of bin
 *******************************************************************************/
module stopwatch
    (
        input  wire       clk100MHz, // main clock, POSedge active
        input  wire       rst,       // asynchronous reset active HIGH
        input  wire       start,     // start button for the satopwatch
        input  wire       stop,      // stop button for the stopwatch
        input  wire [7:0] sw,
        // 7-segment display control (common anode)
        output wire [6:0] sseg_ca,   // segments (active LOW)
        output wire [3:0] sseg_an    // anode enable (active LOW)
    );

    wire        clk100Hz;    // main stopper clock
    wire        clk400Hz;
//------------------------------------------------------------------------------
// clock divider to produce stopwatch 100 Hz clock from 100 MHz external clock

    top_clk_divider u_clk_divider_top
    (
        .clk100MHz(clk100MHz), //input clock 100 MHz
        .rst (rst),            //async reset active high
        .clk_logic (clk100Hz),
        .clk_disp (clk400Hz)
    );

//------------------------------------------------------------------------------
// stopwatch core - 16 bit binary counter

    wire [15:0] counter_bin; // connecting binary counter to binary-to-BCD converter

    counter #(.N(16)) u_counter
    (
        .clk (clk100Hz), //posedge active clock
        .rst (rst),      //async reset active HIGH
        .start (start),  //when 1 counter starts counting
        .stop (stop),    //when 1 counter stops counting
        .counter_value(counter_bin)
    );

//------------------------------------------------------------------------------
// binary to BCD converting

    wire [3:0]  bcd0;        // LSB
    wire [3:0]  bcd1;
    wire [3:0]  bcd2;        // MSB
    wire [3:0]  bcd3;

    bin2bcd u_bin2bcd
    (
        .bin (counter_bin),
        .bcd0(bcd0),
        .bcd1(bcd1),
        .bcd2(bcd2),
        .bcd3(bcd3)
        
    );

//------------------------------------------------------------------------------
// control module for 7-segment display

    sseg_x4 u_sseg_x4
    (
        .clk (clk400Hz), //posedge active clock
        .rst (rst),      //async reset active HIGH
        .bcd0 (bcd0),    //bcd inputs
        .bcd1 (bcd1),
        .bcd2 (bcd2),
        .bcd3 (bcd3),
        .sseg_ca(sseg_ca),
        .sseg_an(sseg_an)
    );
 //-------------------------------------------------------------------------------------
    
    
    
endmodule
