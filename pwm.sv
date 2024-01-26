`timescale 1ns / 1ps
module pwm_module (
    input wire clk,            // Wejœcie zegarowe
    input wire rst,            // Reset
    input wire [7:0] duty_cycle, // Wartoœæ wype³nienia impulsu (0-255)
    output reg pwm_out         // Wyjœcie PWM
);

    reg [7:0] counter = 0;     // 8-bitowy licznik

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter <= 0;
            pwm_out <= 0;
        end else begin
            if (counter < duty_cycle) begin
                pwm_out <= 1;
            end else begin
                pwm_out <= 0;
            end

            if (counter >= 255) begin
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule