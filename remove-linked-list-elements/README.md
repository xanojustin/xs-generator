# Remove Linked List Elements

## Problem

Given the head of a linked list and an integer `val`, remove all the nodes of the linked list that has `Node.val == val`, and return the new head.

### Example
- Input: head = [1,2,6,3,4,6], val = 6
- Output: [1,2,3,4]

### Explanation
Remove all nodes with value 6 from the list [1,2,6,3,4,6]. The resulting list is [1,2,3,4].

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/remove_linked_list_elements.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `nodes` (json): Array of linked list nodes, each with `value` and `next` properties
  - `head` (int?): Index of the head node in the array
  - `val` (int): The value to remove from the list
  
- **Output:**
  - `nodes` (json): Modified array of nodes with all matching values removed
  - `head` (int?): Index of the new head node (null if list becomes empty)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nodes: [{value:1,next:1}, {value:2,next:2}, {value:6,next:3}, {value:3,next:4}, {value:4,next:5}, {value:6,next:null}]`, `head: 0`, `val: 6` | `[1,2,3,4]` |
| `nodes: []`, `head: null`, `val: 1` | `[]` (empty input) |
| `nodes: [{value:7,next:1}, {value:7,next:2}, {value:7,next:3}, {value:7,next:null}]`, `head: 0`, `val: 7` | `[]` (all removed) |
| `nodes: [{value:1,next:1}, {value:2,next:2}, {value:3,next:null}]`, `head: 0`, `val: 4` | `[1,2,3]` (no matches) |
| `nodes: [{value:1,next:null}]`, `head: 0`, `val: 1` | `[]` (single element removed) |

### Edge Cases Explained

1. **Remove from middle and end:** Multiple nodes with target value appear throughout the list
2. **Empty list:** Handle gracefully with empty input
3. **All elements match:** All nodes have the target value, resulting in empty list
4. **No matches:** No nodes have the target value, list unchanged
5. **Single element:** List with one node that matches, becomes empty

## Algorithm

The solution uses a **two-pass approach**:

1. **First pass:** Traverse the list and collect indices of nodes that don't match `val`
2. **Second pass:** Build new nodes array from kept nodes with adjusted next pointers
3. **Edge cases:** Handle empty list, all-removed, and single element cases

**Time Complexity:** O(n) where n is the length of the list
**Space Complexity:** O(n) for the new nodes array and keep_indices

### Alternative Approaches

**Single-pass with in-place modification:** Could be done by updating next pointers while traversing, but with the array representation we need to rebuild anyway.

**Recursive approach:** Process the list recursively, returning the head of the filtered list.
