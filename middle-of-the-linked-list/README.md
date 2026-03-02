# Middle of the Linked List

## Problem

Given the head of a singly linked list, return the middle node of the linked list.

If there are two middle nodes (even number of nodes), return the **second** middle node.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/middle_of_linked_list.xs`):** Contains the solution logic using the slow/fast pointer technique

## Function Signature

- **Input:**
  - `list` (json): Array of nodes, where each node has `value` (any type) and `next` (index of next node or null)
  - `head_index` (int, optional): Index of the head node in the list (default: 0)
- **Output:**
  - Object containing:
    - `nodes`: The original list
    - `middle_index`: Index of the middle node
    - `middle_value`: Value of the middle node

## Algorithm

This solution uses the **tortoise and hare** algorithm (slow/fast pointers):
- Initialize two pointers at the head: `slow` and `fast`
- Move `slow` 1 step at a time, `fast` 2 steps at a time
- When `fast` reaches the end, `slow` is at the middle

**Time Complexity:** O(n) - single pass through the list  
**Space Complexity:** O(1) - only two pointers

## Test Cases

| Input List | Head Index | Expected Middle Index | Expected Middle Value |
|------------|------------|----------------------|----------------------|
| `[1→2→3→4→5]` | 0 | 2 | 3 |
| `[1→2→3→4→5→6]` | 0 | 3 | 4 |
| `[1]` | 0 | 0 | 1 |
| `[]` | 0 | null | null |
| `[10→20]` | 0 | 1 | 20 |

### Test Case Descriptions

1. **Odd length (5 nodes):** Middle is node 3 (index 2)
2. **Even length (6 nodes):** Returns second middle (node 4, index 3)
3. **Single node:** The only node is the middle
4. **Empty list:** Returns null values
5. **Two nodes:** Returns second node as per problem definition

## Example Walkthrough

For list `[1→2→3→4→5]`:
- Initial: slow=0 (value 1), fast=0 (value 1)
- Step 1: slow=1 (value 2), fast=2 (value 3)
- Step 2: slow=2 (value 3), fast=4 (value 5)
- Step 3: fast.next is null, exit loop
- Result: middle is at index 2, value 3 ✓

For list `[1→2→3→4→5→6]`:
- Initial: slow=0 (value 1), fast=0 (value 1)
- Step 1: slow=1 (value 2), fast=2 (value 3)
- Step 2: slow=2 (value 3), fast=4 (value 5)
- Step 3: slow=3 (value 4), fast=null (beyond node 6)
- Result: middle is at index 3, value 4 ✓
