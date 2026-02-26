# Delete Node in a Linked List

## Problem

There is a singly-linked list where each node has an integer value and a reference to the next node. You are given a reference to a node in the linked list (not the head of the list). Write a function to delete that node from the linked list.

**The key constraint:** You do NOT have access to the head of the linked list — you only have direct access to the node that needs to be deleted.

### The Trick

Since we cannot access the previous node (which would normally be required to delete a node), we use a clever approach:
1. Copy the value of the next node into the current node
2. Update the current node's `next` pointer to skip the next node
3. This effectively "deletes" the current node by replacing it with the next one

**Note:** This approach only works when the node to delete is not the tail node.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs representing a linked list
- **Function (`function/delete_node.xs`):** Contains the solution logic that performs the deletion

## Function Signature

- **Input:**
  - `node` (object): The node to delete, containing:
    - `val` (int): The integer value of the node
    - `next` (object | null): Reference to the next node in the list

- **Output:**
  - Returns the modified node (object) with the next node's value copied into it and the next pointer updated

## Test Cases

### Basic Case

**Input:** Node with value `4` in the list `4 -> 5 -> 1 -> 9`

**Expected Output:** Node with value `5` and next pointing to `1 -> 9`

The list becomes: `5 -> 1 -> 9`

### Single Next Node

**Input:** Node with value `1` in the list `1 -> 2`

**Expected Output:** Node with value `2` and next pointing to `null`

The list becomes: `2`

### Edge Case: Node in Middle of Longer List

**Input:** Node with value `3` in the list `1 -> 2 -> 3 -> 4 -> 5`

**Expected Output:** Node with value `4` and next pointing to `5`

The list becomes: `1 -> 2 -> 4 -> 5`

## Example Walkthrough

For the input list `4 -> 5 -> 1 -> 9` and node to delete = `4`:

1. We can see the next node has value `5` and points to `1 -> 9`
2. We copy value `5` into the current node (overwriting `4`)
3. We update the current node's next pointer to point to `1 -> 9`
4. The node now represents value `5` with next pointing to `1 -> 9`
5. The original node containing `5` is effectively removed from the list

## Constraints

- The node to be deleted is not the tail node of the list
- The linked list has at least 2 nodes
- All node values are integers

## Complexity Analysis

- **Time Complexity:** O(1) - We only perform a constant amount of operations regardless of list size
- **Space Complexity:** O(1) - We only use a constant amount of extra space
