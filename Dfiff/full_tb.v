module full_adder_4bit_tb;

reg clk, rst, cin;
reg [3:0] a, b;

wire [3:0] sum;
wire carry;

integer i, j, c;
integer pass, fail;

reg [4:0] expected;

full_adder_4bit uut(
    .clk(clk),
    .rst(rst),
    .a(a),
    .b(b),
    .cin(cin),
    .sum(sum),
    .carry(carry)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;

initial begin

    pass = 0;
    fail = 0;

    // Initial indeterminate state
    rst = 0;
    a = 0;
    b = 0;
    cin = 0;

    #2;

    if((^sum === 1'bx) && (carry === 1'bx))
        $display("PASS: INITIAL INDETERMINATE STATE (X)");
    else
        $display("FAIL: INITIAL STATE");

    // Reset
    rst = 1;
    #2;

    if(sum == 0 && carry == 0)
        $display("PASS: RESET");

    rst = 0;

    // Test all 512 combinations
    for(i = 0; i < 16; i = i + 1) begin
        for(j = 0; j < 16; j = j + 1) begin
            for(c = 0; c < 2; c = c + 1) begin

                @(negedge clk);

                a = i;
                b = j;
                cin = c;

                expected = i + j + c;

                @(posedge clk);
                #1;

                if({carry, sum} == expected) begin
                    pass = pass + 1;
                    $display(
                    "PASS: A=%d B=%d CIN=%b SUM=%d CARRY=%b",
                    a, b, cin, sum, carry);
                end
                else begin
                    fail = fail + 1;
                    $display(
                    "FAIL: A=%d B=%d CIN=%b SUM=%d CARRY=%b",
                    a, b, cin, sum, carry);
                end

            end
        end
    end

    // Final result
    $display("-----------------------------");
    $display("TOTAL TESTS = %d", pass+fail);
    $display("PASS = %d", pass);
    $display("FAIL = %d", fail);

    if(fail == 0)
        $display("ALL TESTS PASSED");
    else
        $display("TEST FAILED");

    $finish;

end

endmodule