# Largest Perimeter Triangle

## Problem
Given an integer array `sides` representing the lengths of sticks, return the largest perimeter of a triangle that can be formed with any 3 of these lengths. If no triangle can be formed, return 0.

### Triangle Inequality
For three sides to form a valid triangle where a ≤ b ≤ c, they must satisfy:
- a + b > c

This means the sum of the two smaller sides must be strictly greater than the largest side.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/largest_perimeter_triangle.xs`):** Contains the greedy algorithm solution

## Function Signature
- **Input:** 
  - `sides` (int[]): Array of integers representing side lengths
- **Output:** 
  - (int): Largest perimeter of a valid triangle, or 0 if no triangle can be formed

## Algorithm
The greedy approach works because:
1. Sort the sides in descending order (largest first)
2. Check consecutive triplets starting from the largest
3. The first valid triangle found will have the largest possible perimeter
4. Why? If a triplet (a, b, c) with a ≥ b ≥ c satisfies b + c > a, any smaller a' < a would give a smaller perimeter

### Time Complexity
- O(n log n) due to sorting, where n is the number of sides

### Space Complexity
- O(1) additional space (or O(n) depending on sort implementation)

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 6, 2, 3]` | 8 | Triangle (3, 3, 2) has perimeter 8; (6, 3, 3) is invalid because 3+3=6 |
| `[1, 2, 1]` | 0 | No valid triangle: 1+1=2, which is not > 2 |
| `[2, 1, 2]` | 5 | Triangle (2, 2, 1) has perimeter 5 |
| `[3, 2, 3, 4]` | 10 | Triangle (4, 3, 3) has perimeter 10 |
| `[1, 1, 1]` | 3 | Equilateral triangle with perimeter 3 |
| `[1, 2]` | 0 | Not enough sides to form a triangle |
| `[5, 5, 5, 5]` | 15 | Any three 5s form an equilateral triangle with perimeter 15 |
