# Sort Characters By Frequency

## Problem
Given a string, sort the characters by their frequency in descending order. If two characters have the same frequency, sort them alphabetically (ascending).

### Examples:
- **Input:** "tree" → **Output:** "eert" (or "eetr" - 'e' appears twice, 'r' and 't' appear once, sorted alphabetically)
- **Input:** "cccaaa" → **Output:** "cccaaa" or "aaaccc" (both 'c' and 'a' appear 3 times)
- **Input:** "Aabb" → **Output:** "bbAa" or "bbaA" (case-sensitive: 'b' appears twice, 'A' and 'a' appear once)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs and logs results
- **Function (`function/sort-characters-by-frequency.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `input_string` (text) - The string to sort characters by frequency
- **Output:** 
  - `result` (text) - The string with characters sorted by frequency in descending order

## Algorithm
1. Split the input string into an array of individual characters
2. Group characters by their value using `index_by` to create a frequency map
3. Transform the grouped object into an array of `{ char, count }` objects
4. Sort by character alphabetically (ascending) as a secondary sort
5. Sort by count (descending) as the primary sort
6. Build the result by repeating each character according to its count
7. Join all repeated characters into the final string

## Test Cases

| Input | Expected Output | Notes |
|-------|-----------------|-------|
| "tree" | "eert" | Basic case - 'e' appears twice |
| "cccaaa" | "aaaccc" or "cccaaa" | Tie-breaking - both have same frequency |
| "Aabb" | "bbAa" or "bbaA" | Case sensitivity - 'A' and 'a' are different |
| "" | "" | Empty string edge case |
| "z" | "z" | Single character edge case |
| "aaaa" | "aaaa" | All same characters boundary case |
| "hello world" | varies | Complex string with spaces |

## XanoScript Features Used
- `split:""` - Split string into characters
- `index_by:$$` - Group array elements by value
- `get_keys` - Get all keys from an object
- `map` - Transform arrays
- `sort` - Sort arrays by field
- `repeat` - Repeat a value N times
- `join:""` - Join array into string
