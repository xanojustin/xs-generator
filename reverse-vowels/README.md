# Reverse Vowels

## Problem
Write a function that reverses only the vowels in a given string. The vowels are 'a', 'e', 'i', 'o', and 'u', and they can appear in both lowercase and uppercase. Consonants should remain in their original positions.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_vowels.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `s` (text): The input string to process
- **Output:** 
  - (text): The string with vowels reversed

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"hello"` | `"holle"` | 'e' and 'o' are vowels, reversed to 'o' and 'e' |
| `"leetcode"` | `"leotcede"` | Vowels 'e','e','o','e' reversed to 'e','o','e','e' |
| `"aA"` | `"Aa"` | Case-sensitive: 'a' and 'A' are both vowels |
| `""` | `""` | Empty string edge case |
| `"xyz"` | `"xyz"` | No vowels - string unchanged |
| `"aeiou"` | `"uoiea"` | All vowels, fully reversed |
