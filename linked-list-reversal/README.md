# Linked List Reversal

## Problem

Reverse a singly linked list.

Given the head of a singly linked list, reverse the list and return the new head. Each node in the list has a `value` (integer) and a `next` pointer (reference to the next node or null).

This is a classic data structure exercise that tests pointer manipulation and understanding of linked list traversal.

## Function Signature

- **Input:** `head` (json) - The head node of the linked list with structure `{ value: int, next: node|null }`, or `null` for an empty list
- **Output:** `json` - The new head node after reversal, or `null` if the input was empty

## Linked List Node Structure

```json
{
  "value": 1,
  "next": {
    "value": 2,
    "next": {
      "value": 3,
      "next": null
    }
  }
}
```

This represents the list: 1 → 2 → 3

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `{ "value": 1, "next": { "value": 2, "next": { "value": 3, "next": null } } }` | `{ "value": 3, "next": { "value": 2, "next": { "value": 1, "next": null } } }` (list: 3 → 2 → 1) |
| `{ "value": 1, "next": null }` | `{ "value": 1, "next": null }` (single node) |
| `null` | `null` (empty list) |
| `{ "value": 1, "next": { "value": 2, "next": null } }` | `{ "value": 2, "next": { "value": 1, "next": null } }` (two nodes) |

### Edge Cases Explained

1. **Empty list (null)**: Returns null - the reversed empty list is still empty
2. **Single node**: Returns the same node - reversing a single-element list is a no-op
3. **Two nodes**: Tests the basic reversal mechanism
4. **Multiple nodes**: Tests the full iterative reversal algorithm with multiple pointer updates

## Algorithm Explanation

The iterative approach uses three pointers:
- `prev`: The node that will become the new next pointer (starts as null)
- `current`: The node we're currently processing
- `next`: Temporary storage for the original next pointer before we overwrite it

For each node:
1. Save the next node
2. Reverse the current node's pointer to point to prev
3. Move prev and current forward

Time Complexity: O(n) - we visit each node once
Space Complexity: O(1) - we only use three pointers regardless of list size
