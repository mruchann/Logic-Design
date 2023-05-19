`timescale 1ns / 1ps

module bh(input B, input H, input clk, output reg Q);

    initial begin
        Q = 1;
    end

    always @(posedge clk) begin
        case ({B,H})
        2'b00: Q <= ~Q;
        2'b01: Q <= 1'b1;
        2'b10: Q <= 1'b0;
        2'b11: Q <= Q;
        endcase
    end

endmodule

module ic1337(// Inputs
              input A0,
              input A1,
              input A2,
              input clk,
              // Outputs
              output Q0,
              output Q1,
              output Z);

    bh top_bh(
        ((A0)^(~A1)) | A2,
        (A0) & (~A2),
        clk,
        Q0
    );    

    bh bottom_bh(
        (A0) & (~A2),
        ((~A0) ~| (A1)) & (A2),
        clk,
        Q1
    );

    assign Z = Q0 ~^ Q1;

endmodule