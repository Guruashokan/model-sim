
module traffic_light_tb;

    reg clk, reset;

    wire [2:0] north, east, south, west;

    traffic_light uut (
        .clk(clk),
        .reset(reset),
        .north(north),
        .east(east),
        .south(south),
        .west(west)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        reset = 1;

        #10 reset = 0;

        #100 $finish;
    end

    initial begin
        $monitor("Time=%0t | N=%b E=%b S=%b W=%b",
                  $time, north, east, south, west);
    end

endmodule
