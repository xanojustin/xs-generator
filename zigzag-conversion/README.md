# Zigzag Conversion

## Problem
The string "PAYPALISHIRING" is written in a zigzag pattern on a given number of rows like this:

```
P   A   H   N
A P L S I I G
Y   I   R
```

And then read line by line: "PAHNAPLSIIGYIR"

Write the code that will take a string and make this conversion given a number of rows.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/zigzag.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `input_string` (text): The string to convert
  - `num_rows` (int): The number of rows in the zigzag pattern
- **Output:** 
  - The converted string read row by row (text)

## Algorithm Explanation
1. Handle edge case: if `num_rows` is 1, return the string unchanged
2. Create an array of empty strings, one for each row
3. Iterate through each character in the input string
4. Append each character to the appropriate row
5. Track direction: moving down until we hit the bottom, then moving up until we hit the top
6. Join all rows together and return the result

## Test Cases

| Input String | num_rows | Expected Output |
|--------------|----------|-----------------|
| "PAYPALISHIRING" | 3 | "PAHNAPLSIIGYIR" |
| "PAYPALISHIRING" | 4 | "PINALSIGYAHRPI" |
| "A" | 1 | "A" |
| "AB" | 1 | "AB" |
| "" | 3 | "" |
| "HELLO" | 5 | "HELLO" (more rows than chars) |

### Example Walkthrough ("PAYPALISHIRING", 3 rows)

**Zigzag pattern:**
```
Row 0: P   A   H   N
Row 1: A P L S I I G
Row 2: Y   I   R
```

**Reading row by row:** PAHN + APLSIIG + YIR = "PAHNAPLSIIGYIR"
