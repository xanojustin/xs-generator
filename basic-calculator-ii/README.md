# Basic Calculator II

## Problem

Given a string `expression` which represents an arithmetic expression containing non-negative integers, `+`, `-`, `*`, `/` operators, and spaces, return the result of evaluating the expression.

### Rules:
- The integer division should **truncate toward zero** (e.g., 7/3 = 2, -7/3 = -2)
- The given expression is always valid
- All intermediate results will be in the range of 32-bit signed integer
- No parentheses are in the expression

### Examples:
- **"3+2*2"** → Output: **7** (Multiplication has higher precedence: 3 + (2*2) = 3 + 4 = 7)
- **" 3/2 "** → Output: **1** (Integer division truncates toward zero)
- **" 3+5 / 2 "** → Output: **5** (5/2 = 2, then 3 + 2 = 5)
- **"14-3/2"** → Output: **13** (3/2 = 1, then 14 - 1 = 13)

### Constraints:
- `1 <= expression.length <= 3 * 10^5`
- Expression contains digits, `+`, `-`, `*`, `/`, and spaces

---

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/calculator.xs`):** Contains the solution logic

---

## Function Signature

- **Input:**
  - `expression` (text): A string containing the arithmetic expression to evaluate
  
- **Output:** (int)
  - The result of evaluating the expression

---

## Algorithm Explanation

The solution uses a **stack-based approach** to handle operator precedence:

1. **Remove spaces** from the expression for easier parsing
2. **Iterate through characters**, building numbers digit by digit
3. **Process operators** when we encounter a new operator or reach the end:
   - **`+`**: Push the current number onto the stack
   - **`-`**: Push the negative of the current number onto the stack
   - **`*`**: Pop the last number, multiply by current number, push result
   - **`/`**: Pop the last number, divide by current number (truncating toward zero), push result
4. **Sum all values** in the stack to get the final result

This approach handles precedence naturally: multiplication and division are applied immediately, while addition and subtraction are deferred until the final sum.

---

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| "3+2*2" | 7 | 3 + (2*2) = 3 + 4 = 7 |
| " 3/2 " | 1 | Integer division truncates toward zero |
| " 3+5 / 2 " | 5 | 3 + (5/2) = 3 + 2 = 5 |
| "14-3/2" | 13 | 14 - (3/2) = 14 - 1 = 13 |
| "1+1" | 2 | Simple addition |
| "2*3*4" | 24 | Multiple multiplications: ((2*3)*4) = 24 |
| "100-50*2" | 0 | 100 - (50*2) = 100 - 100 = 0 |
| "42" | 42 | Single number, no operators |
| "100/10/2" | 5 | Left to right: (100/10)/2 = 5 |

### Test Case Categories

- **Basic/Happy Path:** "1+1", "3+2*2", "42"
- **Edge Cases:** Single number "42", spaces in expression " 3/2 "
- **Boundary/Interesting:** "100-50*2" (results in zero), "100/10/2" (multiple divisions), "14-3/2" (subtraction with division)

---

## XanoScript Features Used

- **Variable declaration** with `var`
- **Conditional blocks** with `if`, `elseif`
- **Switch statements** for operator handling
- **While loops** for iteration
- **Arrays** for stack operations (`push`, `get`, `count`)
- **String filters** (`substr`, `replace`, `strlen`, `to_int`)
- **Math operations** (`+`, `-`, `*`, `/`, `%`)
- **Function definition** with `input` and `response`
- **Comparison operators** (`>=`, `<=`, `==`, `!=`, `<`, `>`)
- **Logical operators** (`&&`, `||`)
