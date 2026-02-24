# Sort List

## Problem

Given the `head` of a linked list, return the list after sorting it in **ascending order**.

**Constraints:**
- Must sort in O(n log n) time complexity
- Should use O(1) extra space (or minimal extra space for the recursive approach)
- Cannot just convert to array, sort, and rebuild - must work with linked list structure

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/sort_list.xs`):** Main entry point - handles edge cases and calls helper
- **Function (`function/sort_list_helper.xs`):** Recursive merge sort implementation
- **Function (`function/merge_sorted_linked_lists.xs`):** Merges two sorted linked lists

## Algorithm

The solution uses the **merge sort** algorithm adapted for linked lists:

1. **Divide:** Find the middle of the list using slow/fast pointer technique (tortoise and hare)
2. **Conquer:** Recursively sort both halves by calling `sort_list_helper`
3. **Combine:** Merge the two sorted halves using `merge_sorted_linked_lists`

**Time Complexity:** O(n log n) - standard merge sort complexity
**Space Complexity:** O(log n) - recursion stack depth for merge sort

## Function Signature

- **Input:**
  - `nodes` (json): Array of node objects, each with `value` (int) and `next` (int index or null)
  - `head_index` (int | null): Index of the head node in the array, or null if empty
  
- **Output:**
  - `nodes` (json): The sorted array of nodes
  - `head_index` (int | null): Index of the new head node

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[4→2→1→3]` | `[1→2→3→4]` |
| `[-1→5→3→4→0]` | `[-1→0→3→4→5]` |
| `[]` | `[]` |
| `[1]` | `[1]` |
| `[2→1]` | `[1→2]` |
| `[5→4→3→2→1]` | `[1→2→3→4→5]` |

### Test Case Details

**Basic Case:**
- Input: `4 → 2 → 1 → 3`
- Output: `1 → 2 → 3 → 4`

**Negative Numbers:**
- Input: `-1 → 5 → 3 → 4 → 0`
- Output: `-1 → 0 → 3 → 4 → 5`

**Edge Case - Empty List:**
- Input: `[]` (head_index: null)
- Output: `[]` (no change)

**Edge Case - Single Node:**
- Input: `[1]`
- Output: `[1]` (already sorted)

**Edge Case - Two Nodes:**
- Input: `2 → 1`
- Output: `1 → 2`

**Boundary Case - Reverse Sorted:**
- Input: `5 → 4 → 3 → 2 → 1`
- Output: `1 → 2 → 3 → 4 → 5`

## Implementation Notes

The linked list is represented as:
```json
{
  "nodes": [
    { "value": 4, "next": 1 },  // index 0: value=4, points to index 1
    { "value": 2, "next": 2 },  // index 1: value=2, points to index 2
    { "value": 1, "next": 3 },  // index 2: value=1, points to index 3
    { "value": 3, "next": null } // index 3: value=3, end of list
  ],
  "head_index": 0
}
```

The slow/fast pointer technique finds the middle:
- Slow pointer moves 1 step at a time
- Fast pointer moves 2 steps at a time
- When fast reaches the end, slow is at the middle
