# Caesar Cipher

## Problem
Implement the Caesar cipher, a simple substitution cipher where each letter in the plaintext is shifted by a certain number of places down the alphabet. Non-alphabetic characters should remain unchanged.

For example, with a shift of 3:
- A → D, B → E, C → F, ..., X → A, Y → B, Z → C
- a → d, b → e, c → f, ..., x → a, y → b, z → c
- Numbers, spaces, and punctuation remain unchanged

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/caesar-cipher.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `message` (text): The message to encode
  - `shift` (int): Number of positions to shift each letter (positive = right, negative = left)
- **Output:**
  - `encoded` (text): The encoded message with all letters shifted by the specified amount

## Test Cases

| Input Message | Shift | Expected Output |
|---------------|-------|-----------------|
| `"Hello, World!"` | 3 | `"Khoor, Zruog!"` |
| `"ABC"` | 3 | `"DEF"` |
| `"xyz"` | 3 | `"abc"` |
| `"Hello, World!"` | -3 | `"Ebiil, Tloia!"` |
| `"123 !@#"` | 5 | `"123 !@#"` |
| `""` | 5 | `""` |
| `"Zz"` | 1 | `"Aa"` |
| `"Aa"` | -1 | `"Zz"` |

## Example Usage

The run job calls the function with:
```
message: "Hello, World!"
shift: 3
```

Expected result: `"Khoor, Zruog!"`
