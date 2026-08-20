`timescale 1ns/1ps

module fake_news_detector (
    input  wire       clk,
    input  wire       reset,
    input  wire       start,

    // Extracted features from the news article
    input  wire [3:0] sensational_words,
    input  wire [3:0] suspicious_sources,
    input  wire [3:0] emotional_words,
    input  wire [3:0] verified_sources,

    output reg        fake_news,
    output reg        real_news,
    output reg        detection_done,
    output reg [7:0]  fake_score
);

    reg [7:0] score;

    always @(posedge clk) begin
        if (reset) begin
            fake_news      <= 1'b0;
            real_news      <= 1'b0;
            detection_done <= 1'b0;
            fake_score     <= 8'd0;
            score          <= 8'd0;
        end
        else if (start) begin

            // Calculate fake-news score
            // Sensational words = +2 points
            // Suspicious sources = +3 points
            // Emotional words = +1 point
            // Verified sources = -3 points

            score = (sensational_words * 2) +
                    (suspicious_sources * 3) +
                    emotional_words -
                    (verified_sources * 3);

            fake_score <= score;

            // Classification threshold
            if (score >= 8) begin
                fake_news <= 1'b1;
                real_news <= 1'b0;
            end
            else begin
                fake_news <= 1'b0;
                real_news <= 1'b1;
            end

            detection_done <= 1'b1;
        end
        else begin
            detection_done <= 1'b0;
        end
    end

endmodule
