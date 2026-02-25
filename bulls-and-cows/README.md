# Bulls and Cows

## Problem

You are playing the **Bulls and Cows** game. Your friend writes down a secret number and asks you to guess what the number is. When you make a guess, your friend provides a hint with the following info:

- **Bulls**: The number of digits in your guess that exactly match the secret number in both digit and position.
- **Cows**: The number of digits in your guess that exist in the secret number but are located in the wrong position.

Given the secret number and your friend's guess, return the hint in the format `"xAyB"` where:
- `x` is the number of bulls
- `y` is the number of cows

### Example
- Secret: `"1807"`
- Guess: `"7810"`
- Bulls: 1 (the `"0"` at position 2 matches)
- Cows: 3 (the digits `"7"`, `"8"`, and `"1"` are present but in wrong positions)
- Result: `"1A3B"`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/bulls_and_cows.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `secret` (text): The secret number string
  - `guess` (text): The guess number string
  
- **Output:**
  - `bulls` (int): Count of exact matches (digit and position)
  - `cows` (int): Count of partial matches (digit exists, wrong position)
  - `hint` (text): Formatted hint string in `"xAyB"` format

## Test Cases

| Secret | Guess | Expected Bulls | Expected Cows | Hint |
|--------|-------|----------------|---------------|------|
| `"1807"` | `"7810"` | 1 | 3 | `"1A3B"` |
| `"1123"` | `"0111"` | 1 | 1 | `"1A1B"` |
| `"1"` | `"1"` | 1 | 0 | `"1A0B"` |
| `"1234"` | `"5678"` | 0 | 0 | `"0A0B"` |
| `"1111"` | `"1111"` | 4 | 0 | `"4A0B"` |

### Edge Cases Explained

1. **Single digit match** (`"1"` → `"1"`): Single digit exact match
2. **No matches** (`"1234"` → `"5678"`): Completely different digits
3. **All bulls** (`"1111"` → `"1111"`): All digits match exactly
4. **Repeated digits** (`"1123"` → `"0111"`): The second `"1"` in guess matches positionally (bull), but the other `"1"`s only count as one cow since there's only one more `"1"` in the secret
