# Partition List

## Problem

Given the head of a linked list and a value `x`, partition it such that all nodes with values **less than** `x` come before nodes with values **greater than or equal to** `x`.

You should **preserve** the original relative order of the nodes in each of the two partitions.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/partition_list.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `head` (int[]): Linked list represented as an array of integers
  - `x` (int): The partition value
- **Output:**
  - (int[]): The partitioned array with all values < x first, followed by values >= x

## Test Cases

| Input | x | Expected Output |
|-------|---|-----------------|
| `[1, 4, 3, 2, 5, 2]` | 3 | `[1, 2, 2, 4, 3, 5]` |
| `[2, 1]` | 2 | `[1, 2]` |
| `[]` | 1 | `[]` |
| `[1]` | 0 | `[1]` |
| `[3, 3, 3]` | 3 | `[3, 3, 3]` |
| `[5, 4, 3, 2, 1]` | 3 | `[2, 1, 5, 4, 3]` |

### Case Explanations:

1. **Basic case:** `[1, 4, 3, 2, 5, 2]` with x=3 → `[1, 2, 2]` (less than 3) + `[4, 3, 5]` (>= 3) = `[1, 2, 2, 4, 3, 5]`
2. **Two elements:** `[2, 1]` with x=2 → `[1]` + `[2]` = `[1, 2]`
3. **Empty list:** Empty input returns empty output
4. **Single element:** `[1]` with x=0 → all elements >= 0, so stays `[1]`
5. **All equal to x:** All elements >= x, so order preserved
6. **Reverse sorted:** Tests that relative order is maintained in both partitions
