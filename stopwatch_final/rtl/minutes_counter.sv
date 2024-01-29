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
 * 27 Jan 2024, KF - init of module
 *******************************************************************************/


module minutes_counter(
  
    input wire clk,         // Wejœcie zegarowe (1 Hz)
    input wire rst,         // Sygna³ resetuj¹cy
    output reg [9:0] minutes_led  // Wyjœcie na diody LED
);

    reg [12:0] minute_count = 0;  // 6-bitowy licznik mo¿e zliczaæ do 60

   always @(posedge clk or posedge rst) begin
    if (rst) begin
        minute_count <= 0;
        minutes_led <= 0;
    end else if (minute_count >= 6000) begin  // Co minutê
        minute_count <= 0;
        minutes_led <= minutes_led << 1 | 1'b1;  // Przesuñ bity w lewo i ustaw LSB na 1
        if (minutes_led == 8'b11111111) begin  // Jeœli wszystkie diody s¹ zapalone
            minutes_led <= 0;  // Resetuj diody
        end
    end else begin
        minute_count <= minute_count + 1;
    end
end

endmodule


