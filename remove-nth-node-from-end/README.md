# Remove Nth Node From End of List

## Problem

Given the head of a linked list, remove the nth node from the end of the list and return its head.

### Example
- Input: head = [1,2,3,4,5], n = 2
- Output: [1,2,3,5]

### Follow-up
Could you do this in one pass?

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/remove_nth_node_from_end.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nodes` (json): Array of linked list nodes, each with `value` and `next` properties
  - `head` (int?): Index of the head node in the array
  - `n` (int): Position from the end of the node to remove (1-indexed)
  
- **Output:**
  - `nodes` (json): Modified array of nodes with the nth node from end removed
  - `head` (int?): Index of the new head node (null if list becomes empty)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nodes: [{value:1,next:1}, {value:2,next:2}, {value:3,next:3}, {value:4,next:4}, {value:5,next:null}]`, `head: 0`, `n: 2` | `[1,2,3,5]` |
| `nodes: [{value:1,next:null}]`, `head: 0`, `n: 1` | `[]` (empty list) |
| `nodes: [{value:1,next:1}, {value:2,next:null}]`, `head: 0`, `n: 1` | `[1]` |
| `nodes: [{value:1,next:1}, {value:2,next:null}]`, `head: 0`, `n: 2` | `[2]` (remove head) |
| `nodes: []`, `head: null`, `n: 1` | `[]` (empty input) |

### Explanation of Test Cases

1. **Basic case:** Remove 2nd from end of [1,2,3,4,5] → [1,2,3,5]
2. **Single element:** Remove the only element → empty list
3. **Remove tail:** Remove last element of 2-node list → first element remains
4. **Remove head:** Remove first element → only second element remains
5. **Empty list:** Handle gracefully with empty input

## Algorithm

The solution uses the **two-pointer technique**:

1. Calculate the length of the linked list in one pass
2. Determine the position to remove from the start: `length - n`
3. Handle the edge case of removing the head separately
4. For other positions, traverse to the node before the target
5. Skip the target node by updating the previous node's next pointer
6. Rebuild the array with adjusted indices

**Time Complexity:** O(L) where L is the length of the list
**Space Complexity:** O(L) for the new nodes array

### Alternative: One-Pass Solution

For the follow-up, maintain two pointers n nodes apart:
1. Move fast pointer n nodes ahead
2. Move both pointers together until fast reaches end
3. Slow pointer will be at the node before target
4. This achieves O(L) time in a single pass