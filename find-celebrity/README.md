# Find the Celebrity

## Problem

In a party of `n` people, there is exactly one celebrity. A celebrity is defined as someone who:
1. Is known by everyone else
2. Knows no one (including themselves)

You are given a `knows(a, b)` function that returns `true` if person `a` knows person `b`. Implement a function to find the celebrity's index. If there is no celebrity, return `-1`.

### Key Constraints
- There is at most one celebrity
- The celebrity knows nobody (including themselves)
- Everyone knows the celebrity

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (4 people, celebrity at index 2)
- **Function (`function/find_celebrity.xs`):** Contains the solution logic using the two-pointer elimination approach

## Function Signature

- **Input:**
  - `knows_matrix` (json): 2D adjacency matrix where `knows_matrix[i][j] = 1` if person `i` knows person `j`, `0` otherwise
  - `n` (int): Number of people at the party (must be >= 1, validated via precondition)
  
- **Output:**
  - (int): Index of the celebrity, or `-1` if no celebrity exists

## Algorithm

The solution uses a two-phase approach:

1. **Elimination Phase (O(n)):** Start with candidate = 0. For each person i from 1 to n-1, if the current candidate knows person i, then the candidate cannot be the celebrity, so update candidate to i.

2. **Verification Phase (O(n)):** Verify the candidate is actually a celebrity by checking:
   - Everyone knows the candidate
   - The candidate knows no one

Total time complexity: O(n)

## Test Cases

| Input | Expected Output | Description |
|-------|-----------------|-------------|
| `matrix = [[0,1,1,0],[0,0,1,0],[0,0,0,0],[0,1,1,0]], n = 4` | `2` | Happy path: Person 2 is the celebrity (known by all, knows no one) |
| `matrix = [[0]], n = 1` | `0` | Edge case: Single person is trivially a celebrity |
| `matrix = [[0,1],[0,0]], n = 2` | `1` | Basic case: Person 1 is celebrity |
| `matrix = [[0,1,0],[0,0,0],[0,1,0]], n = 3` | `1` | Happy path: Person 1 is celebrity |
| `matrix = [[0,1,0],[1,0,0],[0,0,0]], n = 3` | `-1` | No celebrity: No one satisfies both conditions |
| `matrix = [[0,1,1],[1,0,1],[1,1,0]], n = 3` | `-1` | No celebrity: Everyone knows everyone |
