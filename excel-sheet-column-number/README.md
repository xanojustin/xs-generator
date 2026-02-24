# Excel Sheet Column Number

## Problem
Given a string `column_title` that represents the column title in an Excel sheet, return its corresponding column number.

In Excel, column titles use a base-26 system where:
- A = 1
- B = 2
- ...
- Z = 26
- AA = 27
- AB = 28
- ...
- ZY = 701
- ZZ = 702
- AAA = 703

For example:
- "A" → 1
- "AB" → 28
- "ZY" → 701

## Structure
- **Run Job (`run.xs`):** Calls the test function `run_all_tests`
- **Function (`function/convert_to_number.xs`):** Contains the solution logic to convert column title to number
- **Function (`function/run_all_tests.xs`):** Runs multiple test cases and returns results

## Function Signature
- **Input:** `column_title` (text) — The Excel column title (e.g., "A", "AA", "ZY")
- **Output:** (int) — The corresponding column number

## Algorithm
The solution treats the column title as a base-26 number where 'A' = 1, 'B' = 2, ..., 'Z' = 26:
1. Initialize result to 0
2. For each character in the string:
   - Convert character to its value (ord(char) - ord('A') + 1 = ord(char) - 64)
   - Update result: `result = result * 26 + char_value`
3. Return the final result

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| "A" | 1 |
| "B" | 2 |
| "Z" | 26 |
| "AA" | 27 |
| "AB" | 28 |
| "AZ" | 52 |
| "BA" | 53 |
| "ZY" | 701 |
| "ZZ" | 702 |
| "AAA" | 703 |
| "CVC" | 2147 |
| "aa" | 27 |

### Test Categories
- **Basic/happy-path:** A, B, Z, AA, AB
- **Edge cases:** Single letters (A, Z), double letters (AA, ZZ)
- **Boundary cases:** ZY→701, ZZ→702, AAA→703 (rollover points)
- **Interesting cases:** CVC→2147 (larger value), lowercase "aa" (case handling)
