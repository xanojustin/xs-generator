# Basic Calculator

## Problem
Create a calculator that performs basic arithmetic operations: addition, subtraction, multiplication, and division. The calculator should handle invalid operations and division by zero gracefully.

## Structure
- **Run Job (`run.xs`):** Entry point that calls the test runner function
- **Function (`function/calculator.xs`):** Core calculator logic with operation support
- **Function (`function/calculator_test_runner.xs`):** Test orchestrator that runs multiple test cases

## Function Signature
- **Input:** 
  - `operation` (text): The operation to perform - "add", "subtract", "multiply", or "divide"
  - `a` (decimal): First operand
  - `b` (decimal): Second operand
- **Output:** 
  - `operation`: The operation performed
  - `a`: First operand
  - `b`: Second operand  
  - `result`: The calculated result (when successful)
  - `error`: Error message (when operation fails)

## Test Cases
| Input | Expected Output |
|-------|-----------------|
| `operation: "add", a: 10, b: 5` | `result: 15` |
| `operation: "subtract", a: 10, b: 3` | `result: 7` |
| `operation: "multiply", a: 7, b: 6` | `result: 42` |
| `operation: "divide", a: 20, b: 4` | `result: 5` |
| `operation: "divide", a: 10, b: 0` | `error: "Cannot divide by zero"` |
| `operation: "power", a: 2, b: 3` | `error: "Invalid operation..."` |
| `operation: "add", a: -5, b: 3` | `result: -2` |
