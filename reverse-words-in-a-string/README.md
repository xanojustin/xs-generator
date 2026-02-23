# Reverse Words in a String

## Problem
Given an input string `s`, reverse the order of the words.

A **word** is defined as a sequence of non-space characters. The words in `s` will be separated by at least one space.

Return a string of the words in reverse order concatenated by a single space.

**Note:** 
- The input string may contain leading or trailing spaces
- Multiple spaces between words should be reduced to a single space in the output
- The returned string should only have single spaces separating words

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_words.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `input_string` (text): The string to reverse words in
- **Output:** 
  - (text): String with words in reverse order, separated by single spaces

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"the sky is blue"` | `"blue is sky the"` |
| `"  hello world  "` | `"world hello"` |
| `"a good   example"` | `"example good a"` |
| `"single"` | `"single"` |
| `""` | `""` |
| `"   "` | `""` |
