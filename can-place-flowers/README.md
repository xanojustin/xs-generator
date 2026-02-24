# Can Place Flowers

## Problem
You have a long flowerbed where some plots are planted and some are empty. The flowerbed is represented by an integer array `flowerbed` where:
- `0` means the plot is empty
- `1` means the plot is already planted

Flowers cannot be planted in adjacent plots (no two flowers can be next to each other).

Given an integer `n` (number of flowers to plant), return `true` if all `n` flowers can be planted in the flowerbed without violating the no-adjacent-flowers rule, and `false` otherwise.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/can_place_flowers.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `flowerbed` (int[]): Array representing the flowerbed where 0 = empty, 1 = planted
  - `n` (int): Number of flowers to plant
- **Output:** (bool) `true` if all n flowers can be planted, `false` otherwise

## Test Cases

| flowerbed | n | Expected Output |
|-----------|---|-----------------|
| [1, 0, 0, 0, 1] | 1 | true |
| [1, 0, 0, 0, 1] | 2 | false |
| [0, 0, 1, 0, 0] | 2 | true |
| [1, 1, 1, 1, 1] | 1 | false |
| [0, 0, 0, 0, 0] | 3 | true |
| [0] | 1 | true |
| [0] | 0 | true |
| [1] | 1 | false |
| [] | 0 | true |

### Case Explanations:
- **Basic case:** [1, 0, 0, 0, 1] with n=1 → true (can plant in the middle 0)
- **Multiple flowers:** [1, 0, 0, 0, 1] with n=2 → false (only one valid spot)
- **Boundary planting:** [0, 0, 1, 0, 0] with n=2 → true (can plant at both ends)
- **Full flowerbed:** [1, 1, 1, 1, 1] with n=1 → false (no empty plots)
- **Empty flowerbed:** [0, 0, 0, 0, 0] with n=3 → true (can plant at indices 0, 2, 4)
- **Single plot empty:** [0] with n=1 → true
- **Zero flowers to plant:** [0] with n=0 → true (edge case)
- **Single plot occupied:** [1] with n=1 → false
