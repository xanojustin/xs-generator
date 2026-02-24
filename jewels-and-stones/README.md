# Jewels and Stones

## Problem
You're given two strings: `jewels` representing the types of stones that are jewels, and `stones` representing the stones you have. Each character in `stones` is a type of stone you have. Return the number of stones you have that are also jewels.

The letters in `jewels` are guaranteed distinct, and all characters in `jewels` and `stones` are letters. Letters are case sensitive, so "a" is considered a different type of stone from "A".

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/jewels_and_stones.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `jewels` (text): A string of unique characters representing jewel types
  - `stones` (text): A string of characters representing stones you possess
- **Output:** 
  - `count` (int): The number of stones that are also jewels

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| jewels: "aA", stones: "aAAbbbb" | 3 |
| jewels: "z", stones: "ZZ" | 0 |
| jewels: "abc", stones: "abcabc" | 6 |
| jewels: "", stones: "abc" | 0 |
| jewels: "aA", stones: "" | 0 |
| jewels: "x", stones: "xxxxX" | 4 |

## Explanation
- **Example 1:** In "aAAbbbb", 'a' appears once and 'A' appears twice. Both are jewels, so the count is 3.
- **Example 2:** In "ZZ", 'z' doesn't appear, so the count is 0.
- **Edge Cases:** Empty strings should return 0 since there are no stones or jewels to match.
