# Find Kth Bit in Nth Binary String

## Problem

Given two positive integers `n` and `k`, find the `kth` bit in the `nth` binary string `Sn`, where the binary strings are formed as follows:

- `S1 = "0"`
- `Si = Si-1 + "1" + reverse(invert(Si-1))` for `i > 1`

Where:
- `+` denotes string concatenation
- `reverse(x)` returns the reversed string `x`
- `invert(x)` flips all bits in `x` (0 becomes 1, 1 becomes 0)

Return the `kth` bit in `Sn` as a string (`"0"` or `"1"`).

### Example

```
S1 = "0"
S2 = S1 + "1" + reverse(invert(S1)) = "0" + "1" + "1" = "011"
S3 = S2 + "1" + reverse(invert(S2)) = "011" + "1" + "100" = "0111001"
S4 = S3 + "1" + reverse(invert(S3)) = "0111001" + "1" + "1000110" = "01110011000110"
```

## Structure

- **Run Job (`run.xs`):** Calls the test function `find_kth_bit_tests` which runs multiple test cases
- **Function (`function/find_kth_bit.xs`):** Contains the recursive solution logic
- **Test Function (`function/find_kth_bit_tests.xs`):** Wrapper function that runs all test cases

## Function Signature

- **Input:**
  - `n` (int): The iteration number for Sn (1 ≤ n ≤ 20)
  - `k` (int): The position of the bit to find (1-indexed, 1 ≤ k ≤ 2^n - 1)
- **Output:** 
  - Returns a string (`"0"` or `"1"`) representing the kth bit in Sn

## Algorithm Explanation

The solution uses recursion and mathematical properties instead of building the actual string:

1. The length of Sn is always `2^n - 1`
2. The middle position is always `"1"` (this is where the `+ "1" +` happens)
3. The string can be thought of as three parts:
   - Left half: Sn-1
   - Middle: `"1"`
   - Right half: reverse(invert(Sn-1))

**Recursive cases:**
- If `k` is the middle position → return `"1"`
- If `k` is in the left half → recurse on `Sn-1` with the same `k`
- If `k` is in the right half → recurse on `Sn-1` with the mirrored position (`length - k + 1`), then invert the result

**Base case:**
- When `n = 1`, `S1 = "0"`, so return `"0"`

This approach is O(n) time and O(n) space (recursion stack), much more efficient than building a string of length 2^20.

## Test Cases

| Test | n | k | Expected Output | Description |
|------|---|---|-----------------|-------------|
| 1 | 3 | 1 | "0" | First position in S3 |
| 2 | 3 | 5 | "1" | Middle-adjacent position |
| 3 | 4 | 11 | "1" | Higher iteration |
| 4 | 1 | 1 | "0" | Edge case: minimum n |
| 5 | 2 | 3 | "1" | Last position in S2 |

### String Evolution

| n | Sn | Length |
|---|-----|--------|
| 1 | "0" | 1 |
| 2 | "011" | 3 |
| 3 | "0111001" | 7 |
| 4 | "01110011000110" | 15 |
