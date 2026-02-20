# Climbing Stairs

## Problem
You are climbing a staircase. It takes `n` steps to reach the top.

Each time you can either climb **1** or **2** steps. In how many distinct ways can you climb to the top?

### Examples
- **n = 2**: There are 2 ways: (1+1) or (2)
- **n = 3**: There are 3 ways: (1+1+1), (1+2), or (2+1)
- **n = 4**: There are 5 ways: (1+1+1+1), (1+1+2), (1+2+1), (2+1+1), or (2+2)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/climbing_stairs.xs`):** Contains the solution logic using dynamic programming

## Function Signature
- **Input:** 
  - `n` (int): The number of steps to reach the top (must be >= 0)
- **Output:** 
  - (int): The number of distinct ways to climb to the top

## Algorithm Explanation
This problem follows the **Fibonacci sequence** pattern:
- To reach step `i`, you could come from step `i-1` (taking 1 step) or step `i-2` (taking 2 steps)
- Therefore: `ways[i] = ways[i-1] + ways[i-2]`

We use **O(1) space** by only tracking the previous two values instead of an entire array.

## Test Cases
| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 0 | 1 | One way: do nothing (base case) |
| 1 | 1 | One way: single step |
| 2 | 2 | Two ways: 1+1 or 2 |
| 3 | 3 | Three ways: 1+1+1, 1+2, 2+1 |
| 4 | 5 | Five ways (see above) |
| 5 | 8 | Eight ways |
| 10 | 89 | Fibonacci number F(11) |

## Time & Space Complexity
- **Time Complexity:** O(n) - single pass from 2 to n
- **Space Complexity:** O(1) - only storing previous two values
