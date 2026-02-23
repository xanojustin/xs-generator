# Intersection of Two Linked Lists

## Problem
Given two singly linked lists, find the node at which the two lists intersect. If the two linked lists have no intersection, return `null`.

The intersection is defined as the first node that is common to both linked lists. After the intersection point, both lists share the same remaining nodes.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/intersection_linked_lists.xs`):** Contains the solution logic using the two-pointer technique

## Function Signature
- **Input:**
  - `list_a`: Array of objects representing the first linked list nodes, each with `val` (int) and `next` (int or null)
  - `head_a`: Integer index of the head node in `list_a`
  - `list_b`: Array of objects representing the second linked list nodes, each with `val` (int) and `next` (int or null)
  - `head_b`: Integer index of the head node in `list_b`
- **Output:** Integer index of the intersection node, or `null` if no intersection exists

## Algorithm
The solution uses the two-pointer technique with length calculation:
1. Calculate the length of both linked lists
2. Advance the pointer of the longer list by the difference in lengths
3. Move both pointers together one step at a time until they meet
4. Return the intersection index, or `null` if they reach the end without meeting

**Time Complexity:** O(n + m) where n and m are the lengths of the two lists
**Space Complexity:** O(1) - only uses a constant amount of extra space

## Test Cases

### Case 1: Lists intersect (happy path)
| Input | Expected Output |
|-------|-----------------|
| `list_a: [{val:4,next:1},{val:1,next:2},{val:8,next:3},{val:4,next:4},{val:5,next:null}]`, `head_a: 0` | `2` |
| `list_b: [{val:5,next:1},{val:6,next:2},{val:8,next:3},{val:4,next:4},{val:5,next:null}]`, `head_b: 0` | (intersection at index 2) |

### Case 2: No intersection
| Input | Expected Output |
|-------|-----------------|
| `list_a: [{val:1,next:1},{val:2,next:null}]`, `head_a: 0` | `null` |
| `list_b: [{val:3,next:1},{val:4,next:null}]`, `head_b: 0` | (no shared nodes) |

### Case 3: Intersection at the first node (identical lists)
| Input | Expected Output |
|-------|-----------------|
| `list_a: [{val:1,next:1},{val:2,next:null}]`, `head_a: 0` | `0` |
| `list_b: [{val:1,next:1},{val:2,next:null}]`, `head_b: 0` | (intersection at head) |

### Case 4: One list is empty
| Input | Expected Output |
|-------|-----------------|
| `list_a: []`, `head_a: null` | `null` |
| `list_b: [{val:1,next:null}]`, `head_b: 0` | (empty list has no intersection) |

### Case 5: Lists of different lengths with intersection at end
| Input | Expected Output |
|-------|-----------------|
| `list_a: [{val:1,next:null}]`, `head_a: 0` | `0` |
| `list_b: [{val:2,next:1},{val:3,next:2},{val:1,next:null}]`, `head_b: 0` | (intersection at last node) |
