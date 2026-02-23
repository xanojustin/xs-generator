# Add Two Numbers

## Problem
You are given two non-empty linked lists representing two non-negative integers. The digits are stored in reverse order, and each node contains a single digit. Add the two numbers and return the sum as a linked list.

You may assume the two numbers do not contain any leading zero, except the number 0 itself.

**Example 1:**
```
Input: l1 = [2,4,3], l2 = [5,6,4]
Output: [7,0,8]
Explanation: 342 + 465 = 807
```

**Example 2:**
```
Input: l1 = [0], l2 = [0]
Output: [0]
```

**Example 3:**
```
Input: l1 = [9,9,9,9,9,9,9], l2 = [9,9,9,9]
Output: [8,9,9,9,0,0,0,1]
```

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs (342 + 465 = 807)
- **Function (`function/add_two_numbers.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `l1`: JSON array representing the first linked list, each element has:
    - `value`: int (the digit 0-9)
    - `next`: int? (index of next node, null if end of list)
  - `l2`: JSON array representing the second linked list, same structure
  - `head1`: int? (starting index for l1, defaults to 0)
  - `head2`: int? (starting index for l2, defaults to 0)
- **Output:** JSON array representing the sum as a linked list, each element has:
  - `value`: int (the digit 0-9)
  - `next`: int? (index of next node, null if end of list)

## Test Cases

| Input l1 | Input l2 | Expected Output | Explanation |
|----------|----------|-----------------|-------------|
| `[2,4,3]` | `[5,6,4]` | `[7,0,8]` | 342 + 465 = 807 |
| `[0]` | `[0]` | `[0]` | 0 + 0 = 0 |
| `[9,9,9,9,9,9,9]` | `[9,9,9,9]` | `[8,9,9,9,0,0,0,1]` | 9999999 + 9999 = 10008998 |

**Notes:**
- The linked list representation uses an array where each node points to the next via index
- `next: null` indicates the end of the list
- The digits are stored in reverse order (least significant digit first)
