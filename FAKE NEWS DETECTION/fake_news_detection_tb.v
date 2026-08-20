`timescale 1ns/1ps

module fake_news_detector_tb;

    reg clk;
    reg reset;
    reg start;

    reg [3:0] sensational_words;
    reg [3:0] suspicious_sources;
    reg [3:0] emotional_words;
    reg [3:0] verified_sources;

    wire fake_news;
    wire real_news;
    wire detection_done;
    wire [7:0] fake_score;

    fake_news_detector uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .sensational_words(sensational_words),
        .suspicious_sources(suspicious_sources),
        .emotional_words(emotional_words),
        .verified_sources(verified_sources),
        .fake_news(fake_news),
        .real_news(real_news),
        .detection_done(detection_done),
        .fake_score(fake_score)
    );

    // Clock
    always #5 clk = ~clk;

    // Test one news article
    task test_news;
        input [3:0] sensational;
        input [3:0] suspicious;
        input [3:0] emotional;
        input [3:0] verified;

        begin
            sensational_words = sensational;
            suspicious_sources = suspicious;
            emotional_words = emotional;
            verified_sources = verified;

            start = 1'b1;

            #10;

            start = 1'b0;

            #2;

            $display("--------------------------------");
            $display("Sensational Words : %d", sensational);
            $display("Suspicious Sources: %d", suspicious);
            $display("Emotional Words   : %d", emotional);
            $display("Verified Sources  : %d", verified);
            $display("Fake Score        : %d", fake_score);

            if (fake_news)
                $display("RESULT: FAKE NEWS");
            else if (real_news)
                $display("RESULT: REAL NEWS");

            $display("--------------------------------");
        end
    endtask

    initial begin

        clk = 0;
        reset = 1;
        start = 0;

        sensational_words = 0;
        suspicious_sources = 0;
        emotional_words = 0;
        verified_sources = 0;

        #10;

        reset = 0;

        // Test 1: Likely fake news
        test_news(4'd4, 4'd2, 4'd3, 4'd0);

        // Test 2: Likely real news
        test_news(4'd1, 4'd0, 4'd1, 4'd3);

        // Test 3: Likely fake news
        test_news(4'd3, 4'd2, 4'd2, 4'd0);

        #20;

        $finish;
    end

endmodule
