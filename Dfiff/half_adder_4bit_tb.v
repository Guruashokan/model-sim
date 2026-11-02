module half_adder_4bit_tb;

reg clk, rst;
reg [3:0] a, b;

wire [3:0] sum;
wire carry;

integer i, j;
integer pass, fail;

reg [4:0] expected;

half_adder_4bit uut(
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .sum(sum),
    .carry(carry)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;

initial begin

    pass = 0;
    fail = 0;

    // Test 1: Indeterminate state
    rst = 0;
    a = 4'b0010;
    b = 4'b0011;

    #2;

    if((^sum === 1'bx) && (carry === 1'bx))
        $display("PASS: Initial state is INDETERMINATE (X)");
    else
        $display("FAIL: Initial state");

    // Test 2: Reset
    rst = 1;
    #2;

    if(sum == 0 && carry == 0)
        $display("PASS: RESET");

    rst = 0;

    // Test 3: All 256 combinations
    for(i = 0; i < 16; i = i + 1) begin
        for(j = 0; j < 16; j = j + 1) begin

            @(negedge clk);

            a = i;
            b = j;

            expected = i + j;

            @(posedge clk);
            #1;

            if({carry, sum} == expected) begin
                pass = pass + 1;
                $display("PASS: A=%d B=%d SUM=%d CARRY=%b",
                         a, b, sum, carry);
            end
            else begin
                fail = fail + 1;
                $display("FAIL: A=%d B=%d", a, b);
            end

        end
    end

    $display("--------------------------");
    $display("TOTAL = %d", pass+fail);
    $display("PASS = %d", pass);
    $display("FAIL = %d", fail);

    if(fail == 0)
        $display("ALL TESTS PASSED");

    $finish;

end

endmodule