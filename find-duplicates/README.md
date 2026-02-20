# Find Duplicates

## Problem
Given an array of integers, find all elements that appear more than once. Return each duplicate element only once in the result, regardless of how many times it appears in the input.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_duplicates.xs`):** Contains the solution logic using a frequency map approach

## Function Signature
- **Input:** `int[] numbers` - An array of integers to check for duplicates
- **Output:** `int[]` - An array of integers that appear more than once in the input (each duplicate appears only once in the result)

## Approach
This solution uses a frequency counting approach:
1. First pass: Count how many times each number appears using an object as a frequency map
2. Second pass: Collect numbers with count > 1 into the result array (ensuring each duplicate is only added once)

Time Complexity: O(n) where n is the length of the array
Space Complexity: O(n) for storing the frequency map

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 3, 2, 4, 3, 5, 6, 1]` | `[1, 2, 3]` |
| `[1, 1, 1, 1]` | `[1]` |
| `[]` | `[]` |
| `[1, 2, 3, 4, 5]` | `[]` |
| `[5, 5, 5, 2, 2, 3]` | `[5, 2]` |

### Test Case Explanations

1. **Basic case with multiple duplicates:** Input `[1, 2, 3, 2, 4, 3, 5, 6, 1]` has duplicates 1, 2, and 3. Each appears in the result exactly once.

2. **All same elements:** Input `[1, 1, 1, 1]` should return `[1]` - the duplicate appears only once in the result.

3. **Empty array:** Edge case - returns empty array with no duplicates.

4. **No duplicates:** Input with all unique elements returns empty array.

5. **Multiple duplicates with different frequencies:** Input `[5, 5, 5, 2, 2, 3]` returns `[5, 2]` - 5 appears 3 times, 2 appears twice, both are included once.
