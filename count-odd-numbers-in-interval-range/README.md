# Count Odd Numbers in Interval Range

## Problem

Given two non-negative integers `low` and `high`, return the count of odd numbers between `low` and `high` (inclusive).

### Examples
- Input: low = 3, high = 7 → Output: 3 (odd numbers are 3, 5, 7)
- Input: low = 2, high = 8 → Output: 3 (odd numbers are 3, 5, 7)

## Structure

- **Run Job (`run.xs`):** Calls the test function that runs multiple test cases
- **Function (`function/count_odd_numbers.xs`):** Contains the solution logic using a mathematical formula
- **Test Function (`function/count_odd_numbers_tests.xs`):** Runs multiple test cases and returns all results

## Function Signature

### count_odd_numbers
- **Input:**
  - `low` (int): Lower bound of the range (inclusive)
  - `high` (int): Upper bound of the range (inclusive)
- **Output:** int - Count of odd numbers in the inclusive range [low, high]

### count_odd_numbers_tests
- **Input:** None
- **Output:** object - Object containing results from all test cases

## Algorithm

The solution uses a mathematical formula instead of iteration for O(1) time complexity:

```
count = ((high + 1) // 2) - (low // 2)
```

This works because:
- `(high + 1) // 2` gives the count of odd numbers from 0 to high
- `low // 2` gives the count of odd numbers from 0 to low-1
- Subtracting gives the count of odd numbers in [low, high]

## Test Cases

| Input (low, high) | Expected Output | Description |
|-------------------|-----------------|-------------|
| (3, 7) | 3 | Basic case - both bounds odd |
| (2, 8) | 3 | Even bounds |
| (5, 5) | 1 | Single odd number |
| (4, 4) | 0 | Single even number (edge case) |
| (1, 100) | 50 | Large range |
| (0, 5) | 3 | Zero included |

## Files

```
count-odd-numbers-in-interval-range/
├── run.xs                              # Run job entry point
├── function/
│   ├── count_odd_numbers.xs           # Solution function
│   └── count_odd_numbers_tests.xs     # Test wrapper function
├── README.md                           # This file
├── CHANGES.md                          # Validation history
└── FEEDBACK.md                         # MCP/tooling feedback
```