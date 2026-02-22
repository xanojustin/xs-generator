# Excel Sheet Column Title

## Problem

Given a positive integer `column_number`, return its corresponding column title as it appears in an Excel sheet.

In Excel, columns are labeled as follows:
- 1 → A
- 2 → B
- ...
- 26 → Z
- 27 → AA
- 28 → AB
- ...
- 52 → AZ
- 53 → BA
- ...
- 702 → ZZ
- 703 → AAA

This is essentially a base-26 number system, but with a twist: there is no "0" digit. The numbers 1-26 map to A-Z, then 27 starts the next "digit" as AA.

## Structure

- **Run Job (`run.xs`):** Calls the `convert_to_title` function with multiple test inputs and compiles the results
- **Function (`function/convert_to_title.xs`):** Contains the core conversion algorithm

## Function Signature

- **Input:** `column_number` (int) — A positive integer representing the column number (1 ≤ column_number)
- **Output:** text — The corresponding Excel column title

## Algorithm

The solution uses a while loop to repeatedly extract digits from the number:

1. Subtract 1 from the number (to handle the 1-based indexing)
2. Get the remainder when divided by 26 (this gives 0-25 instead of 1-26)
3. Convert to character by adding 65 (ASCII value of 'A')
4. Prepend the character to the result
5. Divide the number by 26 (integer division) and continue

This effectively treats the number as base-26 but adjusts for the lack of a zero digit.

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| 1 | A | Minimum/single digit base case |
| 26 | Z | End of first "digit" range |
| 27 | AA | Start of double letters |
| 28 | AB | Double letter increment |
| 52 | AZ | End of A-prefixed double letters |
| 53 | BA | Start of B-prefixed double letters |
| 702 | ZZ | End of double letters |
| 703 | AAA | Start of triple letters |
| 2147 | CVC | Larger number with mixed letters |
