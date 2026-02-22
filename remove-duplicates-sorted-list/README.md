# Remove Duplicates from Sorted List

## Problem
Given a sorted linked list, delete all duplicates such that each element appears only once. Return the modified linked list.

The linked list is represented as an array of nodes where each node has:
- `value`: The data stored in the node
- `next`: The index of the next node (or `null` if it's the tail)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/remove_duplicates_sorted_list.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `list` (json): Array of linked list nodes, each with `value` and `next` fields
  - `head_index` (int?, optional): Index of the head node (defaults to 0)
- **Output:** 
  - `nodes` (json): Modified array of nodes with duplicates removed
  - `head_index` (int?): Index of the head node (null if empty list)

## Algorithm
1. Handle edge cases (empty list, single node, null head)
2. Create a working copy of the node array
3. Traverse the list with a `current` pointer
4. For each node, compare its value with the next node's value
5. If they're equal (duplicate), skip the next node by updating `current.next`
6. If not equal, move to the next node
7. Return the modified list with the same head index

## Time & Space Complexity
- **Time:** O(n) - single pass through the list
- **Space:** O(1) - modifying the list in-place (only using a copy for immutability)

## Test Cases

| Input List | Head Index | Expected Output |
|------------|------------|-----------------|
| `[{value: 1, next: 1}, {value: 1, next: 2}, {value: 2, next: 3}, {value: 3, next: 4}, {value: 3, next: null}]` | 0 | `[1, 2, 3]` (unique values only) |
| `[{value: 1, next: 1}, {value: 2, next: 2}, {value: 3, next: null}]` | 0 | `[1, 2, 3]` (no duplicates) |
| `[]` | 0 | `[]` (empty list) |
| `[{value: 1, next: null}]` | 0 | `[1]` (single element) |
| `[{value: 1, next: 1}, {value: 1, next: 2}, {value: 1, next: null}]` | 0 | `[1]` (all same values) |

### Basic/Happy Path Cases
1. **List with duplicates:** `[1, 1, 2, 3, 3]` → `[1, 2, 3]`
2. **List without duplicates:** `[1, 2, 3]` → `[1, 2, 3]`

### Edge Cases
3. **Empty list:** `[]` → `[]`
4. **Single element:** `[1]` → `[1]`

### Boundary/Interesting Cases
5. **All duplicates:** `[1, 1, 1]` → `[1]` (all same value)
6. **Duplicates at start:** `[1, 1, 2]` → `[1, 2]`
7. **Duplicates at end:** `[1, 2, 2]` → `[1, 2]`
