# Implement StrStr

## Problem
Implement the `strstr` function that finds the first occurrence of a substring (`needle`) within a string (`haystack`). Return the index of the first occurrence, or `-1` if the needle is not found.

This is a classic string matching problem (also known as "Find the Index of the First Occurrence in a String" on LeetCode).

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/strstr.xs`):** Contains the solution logic implementing the naive string matching algorithm

## Function Signature
- **Input:**
  - `haystack` (text): The string to search within
  - `needle` (text): The substring to find
- **Output:**
  - (int): The index of the first occurrence of needle in haystack, or -1 if not found. Returns 0 if needle is empty.

## Test Cases

| Haystack | Needle | Expected Output | Description |
|----------|--------|-----------------|-------------|
| "hello world" | "world" | 6 | Basic case - needle at end |
| "sadbutsad" | "sad" | 0 | Basic case - needle at start |
| "leetcode" | "leeto" | -1 | Needle not found |
| "" | "" | 0 | Edge case - both empty |
| "abc" | "" | 0 | Edge case - empty needle |
| "abc" | "abcd" | -1 | Edge case - needle longer than haystack |
| "mississippi" | "issip" | 4 | Boundary case - overlapping matches |
| "aaaaa" | "bba" | -1 | Boundary case - no match |
| "a" | "a" | 0 | Single character match |
