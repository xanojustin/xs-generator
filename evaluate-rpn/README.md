# Evaluate Reverse Polish Notation (RPN)

## Problem

Evaluate the value of an arithmetic expression in Reverse Polish Notation (postfix notation).

Valid operators are `+`, `-`, `*`, and `/`. Each operand may be an integer or another expression.

**Note:** Division between two integers should truncate toward zero.

Reverse Polish Notation is a mathematical notation in which every operator follows all of its operands. It does not need any parentheses as long as the operators have a fixed number of operands.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/evaluate_rpn.xs`):** Contains the solution logic using a stack

## Function Signature

- **Input:** 
  - `tokens` (text[]): Array of tokens representing the RPN expression. Each token is either an integer or an operator (+, -, *, /)
  
- **Output:** 
  - `int`: The result of evaluating the expression

## Algorithm

The solution uses a stack-based approach:
1. Iterate through each token in the input array
2. If the token is a number, push it onto the stack
3. If the token is an operator, pop the top two elements from the stack, apply the operator, and push the result back
4. The final result is the only element remaining on the stack

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `["2", "1", "+", "3", "*"]` | `9` | ((2 + 1) * 3) = 9 |
| `["4", "13", "5", "/", "+"]` | `6` | (4 + (13 / 5)) = 4 + 2 = 6 |
| `["18"]` | `18` | Single number - edge case |
| `["2", "3", "+"]` | `5` | Simple addition only |
| `["10", "6", "9", "3", "/", "-", "*"]` | `22` | ((10 * (6 - (9 / 3))) = (10 * (6 - 3)) = 30 |

## Complexity Analysis

- **Time Complexity:** O(n) where n is the number of tokens - we process each token once
- **Space Complexity:** O(n) for the stack in the worst case (all numbers before any operators)
