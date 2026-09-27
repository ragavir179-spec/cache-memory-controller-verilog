`timescale 1ns/1ps

module cache_controller_tb;

    reg clk;
    reg reset;
    reg read;
    reg write;

    reg [7:0] address;
    reg [7:0] cpu_write_data;
    reg [7:0] memory_read_data;

    wire [7:0] cpu_read_data;
    wire [7:0] memory_write_data;
    wire [7:0] memory_address;
    wire memory_read;
    wire memory_write;
    wire hit;

    // Instantiate DUT
    cache_controller uut (
        .clk(clk),
        .reset(reset),
        .read(read),
        .write(write),
        .address(address),
        .cpu_write_data(cpu_write_data),
        .memory_read_data(memory_read_data),

        .cpu_read_data(cpu_read_data),
        .memory_write_data(memory_write_data),
        .memory_address(memory_address),
        .memory_read(memory_read),
        .memory_write(memory_write),
        .hit(hit)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin

        // Initial values
        clk = 0;
        reset = 1;
        read = 0;
        write = 0;
        address = 0;
        cpu_write_data = 0;
        memory_read_data = 0;

        // Reset
        #10;
        reset = 0;

        // -------------------------
        // TEST 1: READ MISS
        // -------------------------
        #10;
        read = 1;
        address = 8'h24;
        memory_read_data = 8'hAA;

        #10;
        read = 0;

        // -------------------------
        // TEST 2: READ HIT
        // -------------------------
        #10;
        read = 1;
        address = 8'h24;

        #10;
        read = 0;

        // -------------------------
        // TEST 3: WRITE
        // -------------------------
        #10;
        write = 1;
        address = 8'h24;
        cpu_write_data = 8'h55;

        #10;
        write = 0;

        // -------------------------
        // TEST 4: READ AFTER WRITE
        // -------------------------
        #10;
        read = 1;
        address = 8'h24;

        #10;
        read = 0;

        #20;

        $finish;
    end

endmodule
