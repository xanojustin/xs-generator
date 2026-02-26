# Asteroid Collision

## Problem

We are given an array `asteroids` of integers representing asteroids in a row.

For each asteroid, the absolute value represents its size, and the sign represents its direction (positive meaning right, negative meaning left). Each asteroid moves at the same speed.

Find out the state of the asteroids after all collisions. If two asteroids meet, the smaller one will explode. If both are the same size, both will explode. Two asteroids moving in the same direction will never meet.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/asteroid_collision.xs`):** Contains the solution logic using a stack

## Function Signature

- **Input:** 
  - `asteroids` (int[]): Array of integers representing asteroids
    - Positive value: asteroid moving right
    - Negative value: asteroid moving left
    - Absolute value: size of the asteroid
  
- **Output:** 
  - `int[]`: Array of surviving asteroids after all collisions

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[5, 10, -5]` | `[5, 10]` | The -5 asteroid collides with 10. Since 10 is larger, -5 explodes. |
| `[8, -8]` | `[]` | Both asteroids collide and both explode since they're equal size. |
| `[10, 2, -5]` | `[10]` | 2 and -5 collide (2 explodes), then -5 collides with 10 (10 wins). |
| `[-2, -1, 1, 2]` | `[-2, -1, 1, 2]` | No collisions - negatives move left, positives move right, away from each other. |
| `[1, -1, -2, -2]` | `[-2, -2]` | 1 and -1 collide and both explode. -2s continue left. |
| `[]` | `[]` | Empty input - empty output. |
| `[-1]` | `[-1]` | Single asteroid - no collisions possible. |

## Algorithm

The solution uses a **stack** to track surviving asteroids:

1. Iterate through each asteroid in the input array
2. For each asteroid moving left (negative), check for collisions with asteroids on the stack moving right (positive)
3. Handle three collision scenarios:
   - Stack top is larger: current asteroid explodes
   - Equal sizes: both asteroids explode
   - Current is larger: stack top explodes, continue checking
4. If the current asteroid survives all collisions, push it onto the stack
5. Return the stack as the final state

**Time Complexity:** O(n) - each asteroid is pushed and popped from the stack at most once  
**Space Complexity:** O(n) - for the stack
