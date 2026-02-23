# Reorder List

## Problem

Given a singly linked list, reorder it in-place without modifying node values. Reorder it to the following pattern:

**Original:** L₀ → L₁ → L₂ → ... → Lₙ₋₂ → Lₙ₋₁ → Lₙ

**Reordered:** L₀ → Lₙ → L₁ → Lₙ₋₁ → L₂ → Lₙ₋₂ → ...

The reordering must be done in-place with O(1) extra memory (modifying pointers only, not creating new nodes).

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reorder_list.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `nodes` (json): Array of node objects, each with `value` (int) and `next` (int index or null)
  - `head_index` (int): Index of the head node in the array
  
- **Output:**
  - `nodes` (json): The reordered array of nodes
  - `head_index` (int): Index of the head node (remains 0)

## Algorithm

The solution uses a three-step approach:

1. **Find the middle** of the linked list using slow/fast pointers (tortoise and hare)
2. **Reverse the second half** of the list in-place
3. **Merge the two halves** by alternating nodes from each half

Time Complexity: O(n) - single pass to find middle, single pass to reverse, single pass to merge
Space Complexity: O(1) - only pointer manipulations, no new nodes created

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1→2→3→4]` | `[1→4→2→3]` |
| `[1→2→3→4→5]` | `[1→5→2→4→3]` |
| `[]` | `[]` |
| `[1]` | `[1]` |
| `[1→2]` | `[1→2]` |

### Test Case Details

**Basic Case (Even Length):**
- Input: `1 → 2 → 3 → 4`
- Output: `1 → 4 → 2 → 3`

**Basic Case (Odd Length):**
- Input: `1 → 2 → 3 → 4 → 5`
- Output: `1 → 5 → 2 → 4 → 3`

**Edge Case - Empty List:**
- Input: `[]`
- Output: `[]` (no change)

**Edge Case - Single Node:**
- Input: `[1]`
- Output: `[1]` (no change)

**Edge Case - Two Nodes:**
- Input: `1 → 2`
- Output: `1 → 2` (already in correct order)

**Boundary Case - Longer List:**
- Input: `1 → 2 → 3 → 4 → 5 → 6`
- Output: `1 → 6 → 2 → 5 → 3 → 4`
