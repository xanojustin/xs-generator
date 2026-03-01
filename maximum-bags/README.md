# Maximum Bags With Full Capacity

## Problem

You have `n` bags numbered from `0` to `n-1`. You are given two 0-indexed integer arrays `capacity` and `rocks`. The `i`th bag can hold a maximum of `capacity[i]` rocks and currently contains `rocks[i]` rocks. You are also given an integer `additionalRocks`, the number of additional rocks you can place in any of the bags.

Return the **maximum number of bags** that could have full capacity after placing the additional rocks in some bags.

### Examples

**Example 1:**
- Input: capacity = [2,3,4,5], rocks = [1,2,4,4], additionalRocks = 2
- Output: 3
- Explanation: Bag 0 needs 1 rock, bag 1 needs 1 rock. With 2 additional rocks, we can fill bags 0 and 1. Bag 2 and 3 are already full. Total full bags = 3.

**Example 2:**
- Input: capacity = [10,2,2], rocks = [2,2,0], additionalRocks = 100
- Output: 3
- Explanation: All bags can be filled with the available rocks.

## Structure

- **Run Job (`run.xs`):** Calls the test function that runs multiple test cases
- **Function (`function/maximum_bags.xs`):** Contains the greedy algorithm solution
- **Test Function (`function/maximum_bags_tests.xs`):** Runs multiple test cases and returns all results

## Function Signature

### maximum_bags
- **Input:**
  - `capacity` (int[]): Maximum capacity of each bag
  - `rocks` (int[]): Current number of rocks in each bag
  - `additionalRocks` (int): Number of additional rocks available
- **Output:** int - Maximum number of bags that can be filled to full capacity

### maximum_bags_tests
- **Input:** None
- **Output:** object - Object containing results from all test cases

## Algorithm

The solution uses a **greedy algorithm** approach:

1. **Calculate deficits:** For each bag, compute how many more rocks are needed: `need[i] = capacity[i] - rocks[i]`
2. **Sort deficits:** Sort the needs in ascending order so we can fill bags requiring fewer rocks first
3. **Greedy fill:** Iterate through sorted needs, filling bags as long as we have enough rocks

**Why greedy works:** By filling bags that need the fewest rocks first, we maximize the number of bags we can completely fill with the limited additional rocks.

**Time Complexity:** O(n²) - due to bubble sort implementation (O(n log n) possible with better sort)
**Space Complexity:** O(n) - for the needs array

## Test Cases

| Input (capacity, rocks, additional) | Expected Output | Description |
|-------------------|-----------------|-------------|
| ([2,3,4,5], [1,2,4,4], 2) | 3 | Basic case from example |
| ([10,2,2], [2,2,0], 100) | 3 | All bags can be filled |
| ([5,5,5], [5,5,5], 0) | 3 | All already full, no additional rocks |
| ([10], [5], 3) | 0 | Single bag, not enough rocks |
| ([10], [5], 5) | 1 | Single bag, exact match |
| ([3,3,3], [1,1,1], 3) | 1 | Partial fill - can only complete 1 bag |

## Files

```
maximum-bags/
├── run.xs                              # Run job entry point
├── function/
│   ├── maximum_bags.xs                # Solution function
│   └── maximum_bags_tests.xs          # Test wrapper function
├── README.md                           # This file
├── CHANGES.md                          # Validation history
└── FEEDBACK.md                         # MCP/tooling feedback
```
