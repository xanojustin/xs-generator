# Interval List Intersections

## Problem

Given two lists of closed intervals, each list of intervals is pairwise disjoint and in sorted order.

Return the intersection of these two interval lists.

A closed interval `[a, b]` (with `a <= b`) denotes the set of real numbers `x` with `a <= x <= b`.

The intersection of two closed intervals is a set of real numbers that is either empty, or can be represented as a closed interval. For example, the intersection of `[1, 3]` and `[2, 4]` is `[2, 3]`.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/interval_list_intersections.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `first_list` (object with `intervals` field): A list of closed intervals `[start, end]` sorted by start time
  - `second_list` (object with `intervals` field): A list of closed intervals `[start, end]` sorted by start time
- **Output:** (json array) A list of closed intervals representing the intersection of the two input lists

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `first_list: [[0,2],[5,10],[13,23],[24,25]]`<br>`second_list: [[1,5],[8,12],[15,24],[25,26]]` | `[[1,2],[5,5],[8,10],[15,23],[24,24],[25,25]]` |
| `first_list: [[1,3],[5,9]]`<br>`second_list: []` | `[]` (empty result for empty input) |
| `first_list: [[1,7]]`<br>`second_list: [[3,10]]` | `[[3,7]]` (single overlapping interval) |
| `first_list: [[1,5]]`<br>`second_list: [[5,10]]` | `[[5,5]]` (touching at endpoint) |

## Algorithm

The solution uses a two-pointer approach:
1. Initialize pointers `i` and `j` at the start of both interval lists
2. For each pair of intervals (one from each list), calculate the intersection:
   - `start = max(first_start, second_start)`
   - `end = min(first_end, second_end)`
3. If `start <= end`, there is a valid intersection - add it to results
4. Advance the pointer pointing to the interval that ends first (it can't intersect with any more intervals from the other list)
5. Repeat until one list is exhausted

This runs in O(n + m) time where n and m are the lengths of the input lists, and uses O(1) extra space (excluding the output).
