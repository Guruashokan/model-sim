
module traffic_light (
    input clk,
    input reset,
    output reg [2:0] north,
    output reg [2:0] east,
    output reg [2:0] south,
    output reg [2:0] west
);

    // Traffic light encoding
    parameter RED    = 3'b100;
    parameter YELLOW = 3'b010;
    parameter GREEN  = 3'b001;

    // FSM states
    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;

    reg [1:0] state;

    // State transition
    always @(posedge clk or posedge reset)
    begin
        if (reset)
            state <= S0;
        else
            state <= state + 1'b1;
    end

    // Output logic
    always @(*)
    begin
        // Default: All roads RED
        north = RED;
        east  = RED;
        south = RED;
        west  = RED;

        case(state)

            S0: begin
                north = GREEN;
                east  = RED;
                south = RED;
                west  = RED;
            end

            S1: begin
                north = RED;
                east  = GREEN;
                south = RED;
                west  = RED;
            end

            S2: begin
                north = RED;
                east  = RED;
                south = GREEN;
                west  = RED;
            end

            S3: begin
                north = RED;
                east  = RED;
                south = RED;
                west  = GREEN;
            end

            default: begin
                north = RED;
                east  = RED;
                south = RED;
                west  = RED;
            end

        endcase
    end

endmodule
