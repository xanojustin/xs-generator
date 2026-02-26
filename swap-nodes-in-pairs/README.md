# Swap Nodes in Pairs

## Problem
Given a linked list, swap every two adjacent nodes and return the new head of the modified list.

You must solve the problem without modifying the values in the nodes (i.e., only the `next` pointers may be changed).

For example:
- Input: 1 → 2 → 3 → 4
- Output: 2 → 1 → 4 → 3

If the list has an odd number of nodes, the last node remains in place.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/swap_nodes_in_pairs.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `list` (object[]): Array of nodes, each with `value` (any type) and `next` (int or null)
  - `head_index` (int?, optional): Index of the head node (default: 0)
- **Output:** 
  - Object containing:
    - `nodes` (object[]): The modified linked list with swapped pairs
    - `head_index` (int or null): Index of the new head node

## Test Cases

| Input List (values) | Head Index | Expected Head Index | Expected List Order (values) |
|---------------------|------------|---------------------|------------------------------|
| `[1, 2, 3, 4]` | 0 | 1 | 2 → 1 → 4 → 3 |
| `[1, 2, 3]` | 0 | 1 | 2 → 1 → 3 (odd count, last stays) |
| `[1]` | 0 | 0 | 1 (single node, unchanged) |
| `[]` | 0 | 0 | empty list |
| `[1, 2]` | null | null | unchanged (null head) |

### Example Walkthrough

Input:
```
Index:    0     1     2     3
Value:    1  →  2  →  3  →  4  → null
Next:     1     2     3    null
Head: 0
```

After swapping pairs:
```
Index:    0     1     2     3
Value:    1  ←  2     3  ←  4
Next:     3    null    1     2
Head: 1
```

The list is now: 2 → 1 → 4 → 3 → null

## Algorithm
This implementation iterates through the list in pairs:

1. Handle edge cases (empty list, single node, null head)
2. Create a copy of the list to modify
3. Track `prev_tail` to connect swapped pairs together
4. For each pair:
   - Get the first and second nodes
   - If no second node exists (odd count), we're done
   - Reverse the links: second → first → next_pair
   - Connect previous pair's tail to the new head of this pair
   - Move to the next pair

Time Complexity: O(n) - we visit each node once
Space Complexity: O(1) - we only modify pointers, creating just a copy of the node array
