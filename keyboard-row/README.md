# Keyboard Row

## Problem
Given an array of strings `words`, return the words that can be typed using letters of the alphabet on only one row of American keyboard.

In the American keyboard:
- The top row consists of the characters `"qwertyuiop"`
- The middle row consists of the characters `"asdfghjkl"`
- The bottom row consists of the characters `"zxcvbnm"`

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/keyboard-row.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `words` (text[]): Array of words to check
- **Output:** 
  - `text[]`: Array of words that can be typed using only one keyboard row

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `["Hello", "Alaska", "Dad", "Peace"]` | `["Alaska", "Dad"]` |
| `["omk"]` | `[]` |
| `["adsdf", "sfd"]` | `["adsdf", "sfd"]` |
| `[]` | `[]` |
| `["a", "b", "c"]` | `["a", "b", "c"]` |

### Explanation of Test Cases:
1. **Basic case:** `"Alaska"` uses only middle row (asdfghjkl), `"Dad"` uses only middle row. `"Hello"` and `"Peace"` use multiple rows.
2. **No valid words:** `"omk"` uses characters from both top and middle rows.
3. **All valid:** Both words use only the middle row.
4. **Empty input:** Returns empty array.
5. **Single character words:** All single character words are valid (they only use one row by definition).
