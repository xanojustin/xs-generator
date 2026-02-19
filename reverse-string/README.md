# Reverse String

## Problem
Write a function that reverses a given string. The function should take a string as input and return the characters in reverse order.

**Examples:**
- "Hello" → "olleH"
- "World" → "dlroW"
- "A man a plan" → "nalp a nam A"

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_string.xs`):** Contains the solution logic

## Function Signature
- **Input:** `text` (string) - The string to be reversed
- **Output:** Object containing:
  - `original`: The input string
  - `reversed`: The reversed string

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| "Hello World" | "dlroW olleH" |
| "abc" | "cba" |
| "" | "" (empty string) |
| "a" | "a" (single character) |
| "racecar" | "racecar" (palindrome) |