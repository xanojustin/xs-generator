# Halves Alike

## Problem

Given a string `s` of even length, split this string into two halves of equal lengths. Return `true` if the two halves have the same number of vowels, or `false` otherwise.

The vowels are: `a`, `e`, `i`, `o`, `u`, `A`, `E`, `I`, `O`, `U`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/halves_alike.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `s` (text): A string of even length to be split and analyzed
- **Output:** 
  - (bool): `true` if both halves contain the same number of vowels, `false` otherwise

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"book"` | `true` | "bo" has 1 vowel (o), "ok" has 1 vowel (o) |
| `"textbook"` | `false` | "tex" has 1 vowel (e), "tbook" has 2 vowels (o, o) |
| `"AbCdEfGh"` | `true` | "AbCd" has 1 vowel (A), "EfGh" has 1 vowel (E) |
| `""` | `true` | Empty string: both halves have 0 vowels |
| `"aeiouAEIOU"` | `true` | "aeiou" has 5 vowels, "AEIOU" has 5 vowels |
| `"aabb"` | `false` | "aa" has 2 vowels, "bb" has 0 vowels |

## Notes

- The input string will always have an even length
- Vowel counting is case-sensitive in terms of matching, but both uppercase and lowercase vowels count
- An empty string technically has two equal halves (both empty) and should return `true`
