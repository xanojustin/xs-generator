# Atbash Cipher

## Problem

The Atbash cipher is a substitution cipher that encodes text by replacing each letter with its "mirror" in the alphabet:
- 'a' ↔ 'z'
- 'b' ↔ 'y'
- 'c' ↔ 'x'
- ...and so on

The cipher is symmetric — applying it twice returns the original text. Non-alphabetic characters (numbers, punctuation, spaces) are preserved as-is. The cipher is case-insensitive and returns lowercase output.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/atbash_cipher.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `text` (text): The string to encode/decode
  
- **Output:** 
  - (text): The transformed string using Atbash cipher rules

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"Hello World!"` | `"svool dliow!"` |
| `"abcxyz"` | `"zyxcba"` |
| `""` | `""` |
| `"123 !@#"` | `"123 !@#"` |
| `"The quick brown fox jumps over the lazy dog"` | `"gsv jfrxp yildm ulc qfnkh levi gsv ozab wlt"` |
| `"Svool Dliow"` | `"hello world"` (decoding example) |

### Notes
- The cipher is case-insensitive (input is converted to lowercase)
- Numbers and punctuation are preserved unchanged
- The cipher is symmetric: encode(encode(text)) = text (when case is normalized)
