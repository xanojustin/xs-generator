# Merge Two Sorted Lists

## Problem
You are given the heads of two sorted linked lists. Merge the two lists into a single sorted linked list by splicing together the nodes of the first two lists. Return the head of the merged linked list.

The list should be made by splicing together the nodes of the first two lists.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/merge_two_sorted_lists.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `list1` (json): Array of nodes representing the first linked list
  - `head1` (int, optional): Index of the head node in list1 (null if list is empty)
  - `list2` (json): Array of nodes representing the second linked list
  - `head2` (int, optional): Index of the head node in list2 (null if list is empty)
  
  Each node is an object with:
  - `value` (int): The value stored in the node
  - `next` (int or null): Index of the next node (null if this is the tail)

- **Output:**
  - Object containing:
    - `nodes` (json): Array of nodes representing the merged linked list
    - `head_index` (int): Index of the head node in the merged list (0 if non-empty, null if empty)

## Test Cases

| Input list1 | head1 | Input list2 | head2 | Expected Output (merged values) |
|-------------|-------|-------------|-------|--------------------------------|
| `[{value:1,next:1}, {value:2,next:2}, {value:4,next:null}]` | 0 | `[{value:1,next:1}, {value:3,next:2}, {value:4,next:null}]` | 0 | `[1, 1, 2, 3, 4, 4]` |
| `[]` | null | `[{value:1,next:null}]` | 0 | `[1]` |
| `[{value:1,next:null}]` | 0 | `[]` | null | `[1]` |
| `[]` | null | `[]` | null | `[]` |
| `[{value:2,next:1}, {value:4,next:null}]` | 0 | `[{value:1,next:1}, {value:3,next:null}]` | 0 | `[1, 2, 3, 4]` |

## Example Walkthrough

### Example 1
**Input:**
- list1: `[{value:1,next:1}, {value:2,next:2}, {value:4,next:null}]`, head1: `0`
- list2: `[{value:1,next:1}, {value:3,next:2}, {value:4,next:null}]`, head2: `0`

**Process:**
1. Compare 1 (from list1) and 1 (from list2) → take from list1
2. Compare 2 (from list1) and 1 (from list2) → take from list2
3. Compare 2 (from list1) and 3 (from list2) → take from list1
4. Compare 4 (from list1) and 3 (from list2) → take from list2
5. Compare 4 (from list1) and 4 (from list2) → take from list1
6. List1 exhausted, append remaining 4 from list2

**Output:** `[1, 1, 2, 3, 4, 4]`

## Algorithm
1. Handle edge cases where one or both lists are empty
2. Initialize pointers for both lists (p1, p2)
3. Create a dummy head node to simplify the merging process
4. While both lists have nodes:
   - Compare current node values
   - Append the smaller value to the merged list
   - Advance the pointer of the list we took from
5. Append any remaining nodes from list1
6. Append any remaining nodes from list2
7. Return the merged list (skipping the dummy head)

## Complexity Analysis
- **Time Complexity:** O(n + m) where n and m are the lengths of the two lists. We traverse each list exactly once.
- **Space Complexity:** O(n + m) for the merged list (we create new nodes rather than modifying in-place).