module dff_tb;

reg clk, rst, d;
wire q;

integer pass = 0;
integer fail = 0;

dff uut(
    .clk(clk),
    .rst(rst),
    .d(d),
    .q(q)
);

// Clock generation
initial clk = 0;
always #5 clk = ~clk;

// Test checking task
task check;
input expected;
begin
    if(q == expected) begin
        $display("PASS: Expected=%b Actual=%b", expected, q);
        pass = pass + 1;
    end
    else begin
        $display("FAIL: Expected=%b Actual=%b", expected, q);
        fail = fail + 1;
    end
end
endtask

initial begin

    // Test 1: Reset
    rst = 1;
    d = 0;
    #2;
    check(0);

    // Release reset
    rst = 0;

    // Test 2: Input 1
    d = 1;
    @(posedge clk);
    #1;
    check(1);

    // Test 3: Input 0
    d = 0;
    @(posedge clk);
    #1;
    check(0);

    // Test 4: Input 1
    d = 1;
    @(posedge clk);
    #1;
    check(1);

    // Test 5: Hold output
    d = 0;
    #2;
    check(1);

    // Final result
    $display("----------------------");
    $display("PASS = %0d", pass);
    $display("FAIL = %0d", fail);

    if(fail == 0)
        $display("ALL TESTS PASSED");
    else
        $display("TEST FAILED");

    $finish;

end

endmodule