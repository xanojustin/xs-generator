# Defuse the Bomb

## Problem

You have a bomb to defuse and you are given a **circular array** `code` of integers of length `n` and a key `k`.

To decrypt the code, you must replace every number according to the following rules:

- If `k > 0`: Replace the i-th number with the sum of the **next** `k` numbers
- If `k < 0`: Replace the i-th number with the sum of the **previous** `k` numbers
- If `k == 0`: Replace the i-th number with `0`

Since the array is **circular**:
- The next element of `code[n-1]` is `code[0]`
- The previous element of `code[0]` is `code[n-1]`

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/defuse_bomb.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `code` (int[]): The circular encrypted code array
  - `k` (int): The key indicating how many elements to sum (positive = next, negative = previous, zero = replace with 0)

- **Output:**
  - `int[]`: The decrypted code array

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| [5, 7, 1, 4] | 3 | [12, 10, 16, 13] |
| [1, 2, 3, 4] | 0 | [0, 0, 0, 0] |
| [2, 4, 9, 3] | -2 | [12, 5, 6, 13] |
| [1] | 1 | [1] |

### Explanation of Test Cases:

1. **k = 3:** Each element is replaced by sum of next 3 elements:
   - code[0] = 7 + 1 + 4 = 12
   - code[1] = 1 + 4 + 5 = 10
   - code[2] = 4 + 5 + 7 = 16
   - code[3] = 5 + 7 + 1 = 13

2. **k = 0:** All elements replaced with 0

3. **k = -2:** Each element is replaced by sum of previous 2 elements:
   - code[0] = 3 + 9 = 12
   - code[1] = 2 + 3 = 5
   - code[2] = 4 + 2 = 6
   - code[3] = 9 + 4 = 13

4. **Single element:** With k=1, wraps around to itself

## Algorithm

The solution handles three cases:
1. **k == 0**: Return array of zeros (same length as input)
2. **k > 0**: For each position, sum the next k elements using circular indexing: `(i + j + 1) % n`
3. **k < 0**: For each position, sum the previous |k| elements using circular indexing: `(i - j - 1 + n) % n`

Circular indexing uses modulo arithmetic to wrap around the array boundaries.
