module half_adder_4bit(
    input clk,
    input rst,
    input [3:0] a,
    input [3:0] b,
    output reg [3:0] sum,
    output reg carry
);

wire [4:0] result;

assign result = a + b;

always @(posedge clk or posedge rst)
begin
    if(rst) begin
        sum <= 4'b0000;
        carry <= 1'b0;
    end
    else begin
        sum <= result[3:0];
        carry <= result[4];
    end
end

endmodule