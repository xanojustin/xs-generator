# Caesar Cipher

## Problem

Implement the Caesar cipher encryption algorithm.

The Caesar cipher is a simple substitution cipher where each letter in the plaintext is shifted by a fixed number of positions down the alphabet. For example, with a shift of 3:
- A becomes D
- B becomes E
- Z becomes C (wraps around)
- Non-letter characters remain unchanged
- Case is preserved (uppercase stays uppercase, lowercase stays lowercase)

This is one of the simplest and most widely known encryption techniques, named after Julius Caesar who reportedly used it to communicate with his generals.

## Function Signature

- **Input:** 
  - `text` (text) - The text to encrypt
  - `shift` (int) - The shift amount (positive for encryption, negative for decryption)
- **Output:** `text` - The encrypted/decrypted text

## Test Cases

| Input Text | Shift | Expected Output |
|------------|-------|-----------------|
| "HELLO" | 3 | "KHOOR" |
| "xyz" | 3 | "abc" |
| "ABC" | -3 | "XYZ" |
| "Hello, World!" | 5 | "Mjqqt, Btwqi!" |
| "" | 3 | "" |
| "abc" | 26 | "abc" |
| "abc" | 29 | "def" |
| "123!@#" | 5 | "123!@#" |
| "MixedCASE123" | 1 | "NjYfeDBTF123" |

### Edge Cases Explained

1. **Empty string**: Returns empty string (no characters to shift)
2. **Shift of 26**: Full rotation, text remains unchanged
3. **Shift > 26**: Should wrap properly (shift of 29 = shift of 3)
4. **Negative shift**: Shifts backwards (decryption)
5. **Non-letter characters**: Numbers, spaces, and symbols remain unchanged
6. **Case preservation**: Uppercase letters stay uppercase, lowercase stay lowercase
7. **Wrap around**: Z shifted by 3 becomes C, z shifted by 3 becomes c
