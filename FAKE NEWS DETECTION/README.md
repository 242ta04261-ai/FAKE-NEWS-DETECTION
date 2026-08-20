# Fake News Detection Using Verilog

## Project Description

This project demonstrates a simple hardware-based Fake News Detection system using Verilog HDL.

The system does not directly understand natural-language text. Instead, it receives numerical features extracted from a news article.

The features are:

- Sensational words
- Suspicious sources
- Emotional words
- Verified sources

The detector calculates a fake-news score and classifies the article as either:

- FAKE NEWS
- REAL NEWS

## Detection Algorithm

The fake-news score is calculated as:

Fake Score =
(Sensational Words × 2)
+
(Suspicious Sources × 3)
+
Emotional Words
-
(Verified Sources × 3)

If the score is 8 or greater:

FAKE NEWS

Otherwise:

REAL NEWS


