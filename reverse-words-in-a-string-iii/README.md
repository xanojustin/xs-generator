# Reverse Words in a String III

## Problem

Given a string `s`, reverse the order of characters in each word within a sentence while still preserving whitespace and initial word order.

A word is defined as a sequence of non-space characters. The words in `s` will be separated by at least one space.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/reverse_words.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `s` (text): A string containing words separated by spaces
- **Output:**
  - (text): A string with each word's characters reversed, words remain in original order

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"Let's take LeetCode contest"` | `"s'teL ekat edoCteeL tsetnoc"` |
| `"God Ding"` | `"doG gniD"` |
| `"a"` | `"a"` |
| `""` | `""` |
| `"  hello world  "` | `"  olleh dlrow  "` |

### Test Case Descriptions

1. **Basic case with apostrophe:** `"Let's take LeetCode contest"` → `"s'teL ekat edoCteeL tsetnoc"`
   - Tests handling of punctuation within words
   
2. **Two simple words:** `"God Ding"` → `"doG gniD"`
   - Basic case with capital letters
   
3. **Single character:** `"a"` → `"a"`
   - Edge case: single character word
   
4. **Empty string:** `""` → `""`
   - Edge case: empty input
   
5. **Multiple spaces:** `"  hello world  "` → `"  olleh dlrow  "`
   - Edge case: leading/trailing/multiple spaces between words
