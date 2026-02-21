# Length of Last Word

## Problem

Given a string `s` consisting of words and spaces, return the length of the **last word** in the string.

A **word** is a maximal substring consisting of non-space characters only.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/length_of_last_word.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `s` (text): A string consisting of words and spaces
- **Output:** 
  - (int): The length of the last word in the string

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"Hello World"` | `5` | The last word is "World" with length 5 |
| `"   fly me   to   the moon  "` | `4` | The last word is "moon" with length 4 |
| `"a"` | `1` | Single character word "a" |
| `"     "` | `0` | String with only spaces (edge case) |
| `"luffy is still joyboy"` | `6` | The last word is "joyboy" with length 6 |

## Algorithm

1. **Trim trailing spaces** - Remove whitespace from the end of the string
2. **Split by spaces** - Convert the string into an array of words
3. **Get last element** - Access the final word in the array
4. **Return length** - Use `strlen` filter to get the character count

## Complexity

- **Time Complexity:** O(n) where n is the length of the string
- **Space Complexity:** O(n) for storing the split array
