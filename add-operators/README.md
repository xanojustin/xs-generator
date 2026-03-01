# Add Operators

## Problem

Given a string of digits `num` and an integer `target`, return **all** possible ways to insert binary operators (`+`, `-`, or `*`) between the digits so that the resulting expression evaluates to the target value.

### Rules:
- You can insert operators between any two digits
- You cannot rearrange the digits
- Numbers cannot have leading zeros (e.g., "05" is invalid, but "0" is valid)
- Operator precedence applies: multiplication happens before addition/subtraction
- Return an array of all valid expressions as strings

### Examples:
- Input: `num = "123"`, `target = 6`
  - Output: `["1+2+3", "1*2*3"]`
  - Explanation: 1+2+3 = 6 and 1*2*3 = 6

- Input: `num = "105"`, `target = 5`
  - Output: `["1*0+5", "10-5"]`
  - Explanation: 1*0+5 = 0+5 = 5 and 10-5 = 5

## Structure

- **Run Job (`run.xs`):** Calls the `add_operators` function with multiple test cases and logs the results
- **Function (`function/add_operators.xs`):** Contains the backtracking solution logic

## Function Signature

- **Input:**
  - `num` (text): A string containing only digits (0-9)
  - `target` (int): The target value to evaluate expressions to

- **Output:**
  - (text[]): An array of all valid expressions that evaluate to the target

## Algorithm

This solution uses an **iterative backtracking** approach with a stack:

1. Start with the first digit (or multi-digit number) as the initial value
2. For each position, try all possible next numbers
3. For each next number, try all three operators:
   - **Addition**: Simply add the next number
   - **Subtraction**: Subtract the next number
   - **Multiplication**: Handle precedence by tracking the last operand and adjusting the current value
4. When we reach the end of the string, check if the current value equals the target
5. Collect all valid expressions

### Handling Multiplication Precedence:
To correctly handle operator precedence (multiplication before addition/subtraction), we track:
- `current_val`: The total value so far
- `last_operand`: The value of the last number added/subtracted

When multiplying: `new_val = current_val - last_operand + (last_operand * next_num)`

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `num: "123"`, `target: 6` | `["1+2+3", "1*2*3"]` |
| `num: "5"`, `target: 5` | `["5"]` |
| `num: "105"`, `target: 5` | `["1*0+5", "10-5"]` |
| `num: "123"`, `target: 100` | `[]` (no valid expressions) |
| `num: "1023"`, `target: 6` | `["1+0+2+3", "1*0*2+3", ...]` (various valid combinations) |

### Test Case Details:

1. **Basic case**: Simple addition and multiplication paths
2. **Single digit**: Edge case with minimal input
3. **Multi-digit numbers**: "10" can be used as a single number
4. **No solution**: Returns empty array when no expressions match
5. **Leading zeros**: "02" is invalid, but "0" and "2" separately are valid
