
module half_adder_4bit (
    input  [3:0] A,
    input  [3:0] B,
    output [3:0] Sum,
    output       Carry
);

assign {Carry, Sum} = A + B;

endmodule
