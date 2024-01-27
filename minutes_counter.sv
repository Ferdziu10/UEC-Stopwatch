`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.01.2024 17:06:47
// Design Name: 
// Module Name: minutes_counter
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


module minutes_counter(
  
    input wire clk,         // Wej�cie zegarowe (1 Hz)
    input wire rst,         // Sygna� resetuj�cy
    output reg [9:0] minutes_led  // Wyj�cie na diody LED
);

    reg [12:0] minute_count = 0;  // 6-bitowy licznik mo�e zlicza� do 60

   always @(posedge clk or posedge rst) begin
    if (rst) begin
        minute_count <= 0;
        minutes_led <= 0;
    end else if (minute_count >= 6000) begin  // Co minut�
        minute_count <= 0;
        minutes_led <= minutes_led << 1 | 1'b1;  // Przesu� bity w lewo i ustaw LSB na 1
        if (minutes_led == 8'b11111111) begin  // Je�li wszystkie diody s� zapalone
            minutes_led <= 0;  // Resetuj diody
        end
    end else begin
        minute_count <= minute_count + 1;
    end
end

endmodule


