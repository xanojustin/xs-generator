# Custom Sort String

## Problem
You are given two strings `order` and `s`. All the characters of `order` are unique and were sorted in some custom order previously.

Permute the characters of `s` so that they match the order that `order` was sorted. More specifically, if a character `x` occurs before a character `y` in `order`, then `x` should occur before `y` in the permuted string.

Characters in `s` that are not present in `order` should be placed at the end of the result string in any order.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/custom-sort-string.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `order` (text): A string containing unique characters that defines the custom sort order
  - `s` (text): The string to be sorted according to the custom order
- **Output:** 
  - (text): The sorted string where characters appearing in `order` are sorted according to their position in `order`, followed by characters not in `order`

## Test Cases

| order | s | Expected Output |
|-------|---|-----------------|
| "cba" | "abcd" | "cbad" |
| "cba" | "abcdxyz" | "cbadxyz" |
| "abc" | "" | "" |
| "abc" | "xyz" | "xyz" |
| "cba" | "aabcc" | "ccbbaa" |

### Explanation of Test Cases
1. **Basic case:** Characters in `s` that are in `order` (a, b, c) are sorted as c, b, a. Character d is not in order, so it goes at the end.
2. **With extra characters:** x, y, z are not in `order`, so they go at the end after the sorted characters.
3. **Empty input:** Empty string returns empty string.
4. **No matching characters:** All characters go at the end in their original order.
5. **Duplicates:** Multiple occurrences are handled correctly - both 'a's, both 'c's appear in sorted order.

## Algorithm
1. Build a lookup map from each character in `order` to its index (priority)
2. Iterate through `s` and separate characters into two groups:
   - Those present in `order` (with their priority)
   - Those not in `order`
3. Sort the first group by priority
4. Concatenate: sorted characters + unsorted characters
