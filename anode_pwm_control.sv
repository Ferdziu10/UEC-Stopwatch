`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.01.2024 16:45:00
// Design Name: 
// Module Name: anode_pwm_control
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
