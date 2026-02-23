# Valid Anagram

## Problem
Given two strings `s` and `t`, return `true` if `t` is an anagram of `s`, and `false` otherwise.

An **anagram** is a word or phrase formed by rearranging the letters of a different word or phrase, typically using all the original letters exactly once.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/valid_anagram.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `s` (text): First string to compare
  - `t` (text): Second string to compare
- **Output:** 
  - (bool): `true` if the strings are anagrams, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `s="listen"`, `t="silent"` | `true` |
| `s="anagram"`, `t="nagaram"` | `true` |
| `s="rat"`, `t="car"` | `false` |
| `s=""`, `t=""` | `true` (empty strings are anagrams) |
| `s="a"`, `t="ab"` | `false` (different lengths) |
| `s="Hello"`, `t="hello"` | `true` (case insensitive) |
| `s="Astronomer"`, `t="Moon starer"` | `true` (ignores spaces due to trim) |

## Algorithm
The solution uses a character sorting approach:
1. First checks if the strings have different lengths (quick reject)
2. Splits each string into an array of characters
3. Sorts both character arrays
4. Compares the sorted arrays for equality

**Time Complexity:** O(n log n) due to sorting  
**Space Complexity:** O(n) for the character arrays
