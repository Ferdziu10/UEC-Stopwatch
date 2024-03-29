`timescale 1ns / 1ps
/******************************************************************************
 * (C) Copyright 2023 AGH UST All Rights Reserved
 *
 * MODULE:    top_clk_divider
 * DEVICE:    xc7a35t_0 (BASYS3)
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  Simple stopwatch with start and stop buttons and LCD display
 *
 * HISTORY:
 * 24 Jan 2024, KF - initial version
 *******************************************************************************/


module top_clk_divider(
    input wire clk100MHz, // Wejście zegarowe 100 MHz
    input wire rst,       // Asynchroniczne wejście resetujące
    output logic clk_logic, // Zegar dla wewnętrznej logiki stopera
    output logic clk_disp   // Zegar dla wyświetlacza
    );
    clk_divider 
    #(
        .TARGET_FREQ(1) // Ustawienie docelowej częstotliwości na 100 Hz
    ) u_clk_divider_main (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .clk_div(clk_logic) // Zegar wyjściowy dla logiki stopera
    );
    clk_divider 
    #(
        .TARGET_FREQ(400) // Ustawienie docelowej częstotliwości na 60 Hz
    ) u_clk_divider_dis (
        .clk100MHz(clk100MHz),
        .rst(rst),
        .clk_div(clk_disp) // Zegar wyjściowy dla wyświetlacza
    );

endmodule
