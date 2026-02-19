# Anagram Check

## Problem
Determine if two strings are anagrams of each other. An anagram is a word or phrase formed by rearranging the letters of a different word or phrase, using all the original letters exactly once.

The function:
- Is case-insensitive ("Listen" and "Silent" are anagrams)
- Ignores spaces and non-alphanumeric characters ("A gentleman" and "Elegant man" are anagrams)
- Only considers letters (a-z) and digits (0-9)

## Function Signature
- **Input:** 
  - `str1` (text): First string to compare
  - `str2` (text): Second string to compare
- **Output:** 
  - Returns `true` if the strings are anagrams, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `str1="listen"`, `str2="silent"` | `true` |
| `str1="hello"`, `str2="world"` | `false` |
| `str1="Dormitory"`, `str2="Dirty room"` | `true` |
| `str1=""`, `str2=""` | `true` |
| `str1="a"`, `str2="a"` | `true` |
| `str1="a"`, `str2="b"` | `false` |
| `str1="A gentleman"`, `str2="Elegant man"` | `true` |
| `str1="123"`, `str2="321"` | `true` |
