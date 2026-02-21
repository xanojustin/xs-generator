# Single Number

## Problem

Given a **non-empty** array of integers where every element appears **twice** except for one element which appears only **once**, find that single element.

**Constraints:**
- The solution must have linear runtime complexity (O(n))
- The solution should use only constant extra space (O(1))

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/single_number.xs`):** Contains the XOR-based solution logic

## Function Signature

- **Input:** `nums` (int[]) - Array of integers where every element appears twice except one
- **Output:** `int` - The single element that appears only once

## Solution Approach

This solution uses the **XOR (exclusive or)** bitwise operation which has two key properties:

1. **a ^ a = 0** - Any number XOR itself equals 0
2. **a ^ 0 = a** - Any number XOR 0 equals itself
3. **Commutative and Associative** - Order of operations doesn't matter

By XORing all numbers in the array together, pairs will cancel each other out (becoming 0), leaving only the single number.

### Example Walkthrough

For input `[4, 1, 2, 1, 2]`:
```
4 ^ 1 ^ 2 ^ 1 ^ 2
= 4 ^ (1 ^ 1) ^ (2 ^ 2)    [group pairs together]
= 4 ^ 0 ^ 0                 [pairs cancel out]
= 4                         [result is the single number]
```

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `[4, 1, 2, 1, 2]` | `4` | Standard case with multiple pairs |
| `[2, 2, 1]` | `1` | Simple case with one pair |
| `[1]` | `1` | Edge case: single element |
| `[1, 0, 1]` | `0` | Edge case: zero is the answer |

### Test Case Details

1. **Basic Case:** `[4, 1, 2, 1, 2]` → `4`
   - The number 4 appears once, all others appear twice

2. **Simple Case:** `[2, 2, 1]` → `1`
   - Minimal array with one pair and one single

3. **Edge Case - Single Element:** `[1]` → `1`
   - Array with only one element

4. **Edge Case - Zero Answer:** `[1, 0, 1]` → `0`
   - Tests that 0 is handled correctly
