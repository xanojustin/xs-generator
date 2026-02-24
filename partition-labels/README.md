# Partition Labels

## Problem

Given a string `s`, partition it into as many parts as possible so that each letter appears in at most one part. Return a list of integers representing the size of these parts.

A partition is valid when:
- Each character in the string appears in exactly one partition
- The partitions are created by splitting the string at certain indices
- We want to maximize the number of partitions (i.e., make them as small as possible while satisfying the constraint)

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test input string
- **Function (`function/partition_labels.xs`):** Contains the solution logic using a two-pass greedy algorithm

## Function Signature

- **Input:** 
  - `s` (text): The string to partition
- **Output:** 
  - `int[]`: Array of partition sizes

## Algorithm

1. **First pass:** Find the last occurrence index of each character in the string
2. **Second pass:** Iterate through the string, tracking the farthest last occurrence we've seen
3. When the current index equals the farthest last occurrence, we can make a cut - this forms a valid partition

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"ababcbacadefegdehijhklij"` | `[9, 7, 8]` | Partitions: "ababcbaca" (9), "defegde" (7), "hijhklij" (8) |
| `"abc"` | `[1, 1, 1]` | Each character appears only once, so each gets its own partition |
| `"aaaa"` | `[4]` | All 'a's must be in the same partition |
| `""` | `[]` | Empty string returns empty array |
| `"a"` | `[1]` | Single character returns single partition |

## Example Walkthrough

For input `"ababcbacadefegdehijhklij"`:

1. Last occurrences:
   - a: 8, b: 5, c: 7, d: 14, e: 15, f: 11, g: 13, h: 19, i: 22, j: 23, k: 20, l: 21

2. As we iterate:
   - At index 0 (a), last occurrence is 8, so end = 8
   - At index 1 (b), last occurrence is 5, end stays 8
   - ...
   - At index 8, we reach our end boundary → partition size = 9
   
3. Continue for remaining characters to find partitions of size 7 and 8
