`timescale 1ns / 1ps
/******************************************************************************
 * (C) Copyright 2023 AGH UST All Rights Reserved
 *
 * MODULE:    minutes_counter
 * DEVICE:    xc7a35t_0 (BASYS3)
 * PROJECT:   stopwatch
 *
 * ABSTRACT:  Simple stopwatch with start and stop buttons and LCD display
 *
 * HISTORY:
 * 26 Jan 2024, KF - init of module
 *******************************************************************************/


module anode_pwm_control(
    input wire [3:0] sseg_an_control, // Sterowanie anodami z logiki wyœwietlacza
    input wire pwm,                   // Sygna³ PWM
    output wire [3:0] sseg_an         // Zmodyfikowane sterowanie anodami
);

    // Zastosuj sygna³ PWM do ka¿dej z anod
    assign sseg_an[0] = sseg_an_control[0] | pwm;
    assign sseg_an[1] = sseg_an_control[1] | pwm;
    assign sseg_an[2] = sseg_an_control[2] | pwm;
    assign sseg_an[3] = sseg_an_control[3] | pwm;

endmodule
