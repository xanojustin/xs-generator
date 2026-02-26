# Distribute Candies

## Problem
Alice has `n` candies, where the ith candy is of type `candyType[i]`. Alice noticed that she started to gain weight, so she visited a doctor.

The doctor advised Alice to only eat `n / 2` of the candies she has (n is always even). Alice likes her candies very much, and she wants to eat the maximum number of different types of candies while still following the doctor's advice.

Given the integer array `candyType` of length n, return the maximum number of different types of candies she can eat if she only eats `n / 2` of them.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/distribute_candies.xs`):** Contains the solution logic

## Function Signature
- **Input:** `candy_types` (int[]) - Array of integers where each integer represents a candy type
- **Output:** `int` - Maximum number of different candy types Alice can eat

## Examples

### Example 1
```
Input: candyType = [1, 1, 2, 2, 3, 3]
Output: 3
Explanation: Alice can only eat 6 / 2 = 3 candies. 
Since there are only 3 types, she can eat one of each type.
```

### Example 2
```
Input: candyType = [1, 1, 2, 3]
Output: 2
Explanation: Alice can only eat 4 / 2 = 2 candies. 
Whether she eats types [1,2], [1,3], or [2,3], she still can only eat 2 different types.
```

### Example 3
```
Input: candyType = [6, 6, 6, 6]
Output: 1
Explanation: Alice can only eat 4 / 2 = 2 candies. 
Even though she can eat 2 candies, she only has 1 type.
```

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[1, 1, 2, 2, 3, 3]` | `3` | 6 candies, can eat 3, 3 unique types available |
| `[1, 1, 2, 3]` | `2` | 4 candies, can eat 2, 3 unique types but limited by amount |
| `[6, 6, 6, 6]` | `1` | 4 candies, can eat 2, but only 1 unique type |
| `[1]` | `0` | Edge case: only 1 candy, but n/2 = 0, so can't eat any |
| `[]` | `0` | Edge case: empty array, no candies to eat |
| `[1, 2, 3, 4, 5, 6]` | `3` | 6 candies, can eat 3, 6 unique types but limited to 3 |
| `[1, 1, 1, 1, 2, 2, 2, 2]` | `2` | 8 candies, can eat 4, only 2 unique types |

## Algorithm
The solution involves:
1. Calculate how many candies Alice can eat: `n / 2`
2. Find the number of unique candy types in the array
3. Return the minimum of: unique types vs candies she can eat

**Time Complexity:** O(n²) - Nested loop to find unique types
**Space Complexity:** O(n) - To store unique types

## Notes
- This is a set/problem reduction problem
- The key insight is that Alice is limited by both: the number of candies she can eat AND the variety available
- A more efficient solution would use a hash set for O(n) time complexity
