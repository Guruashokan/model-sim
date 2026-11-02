
module half_adder_4bit_tb;

reg [3:0] A, B;
wire [3:0] Sum;
wire Carry;

half_adder_4bit uut (
    .A(A),
    .B(B),
    .Sum(Sum),
    .Carry(Carry)
);

initial begin

    $monitor("Time=%0t A=%b B=%b Sum=%b Carry=%b",
              $time, A, B, Sum, Carry);

    A = 4'b0000; B = 4'b0000; #10;
    A = 4'b0011; B = 4'b0010; #10;
    A = 4'b0101; B = 4'b0011; #10;
    A = 4'b0111; B = 4'b0100; #10;
    A = 4'b1001; B = 4'b0110; #10;
    A = 4'b1111; B = 4'b0001; #10;
    A = 4'b1111; B = 4'b1111; #10;

    $finish;
end

endmodule
