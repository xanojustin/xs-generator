# License Key Formatting

## Problem
You are given a license key represented as a string `s` that consists of only alphanumeric characters and dashes. The string is separated into `n + 1` groups by `n` dashes. You are also given an integer `k`.

We want to reformat the string `s` such that each group contains exactly `k` characters, except for the first group, which could be shorter than `k` but still must contain at least one character. Furthermore, there must be a dash inserted between two groups, and you should convert all lowercase letters to uppercase.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/format_license_key.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `s` (text): The license key string containing alphanumeric characters and dashes
  - `k` (int): The number of characters per group
- **Output:** (text) The reformatted license key in uppercase with dashes every k characters

## Test Cases

| Input | k | Expected Output |
|-------|---|-----------------|
| `"5F3Z-2e-9-w"` | 4 | `"5F3Z-2E9W"` |
| `"2-4A0r7-4k"` | 4 | `"24A0-R74K"` |
| `"---"` | 3 | `""` |
| `"a-a-a-a"` | 2 | `"AA-AA"` |
| `"ABC"` | 1 | `"A-B-C"` |

### Test Case Explanations

1. **Basic case:** `"5F3Z-2e-9-w"` with `k=4` → `"5F3Z-2E9W"`
   - Cleaned: `"5F3Z2E9W"`
   - First group: `"5F3Z"` (4 chars, since 8 % 4 = 0, first group is full k)
   - Second group: `"2E9W"`
   - Result: `"5F3Z-2E9W"`

2. **First group smaller:** `"2-4A0r7-4k"` with `k=4` → `"24A0-R74K"`
   - Cleaned: `"24A0R74K"`
   - First group: `"24A0"` (4 chars, since 8 % 4 = 0)
   - Second group: `"R74K"`
   - Result: `"24A0-R74K"`

3. **Edge case - only dashes:** `"---"` with `k=3` → `""`
   - Cleaned becomes empty string
   - Result is empty

4. **Multiple dashes to remove:** `"a-a-a-a"` with `k=2` → `"AA-AA"`
   - Cleaned: `"aaaa"`
   - First group: `"AA"` (2 chars)
   - Second group: `"AA"`
   - Result: `"AA-AA"`

5. **Boundary case - k=1:** `"ABC"` with `k=1` → `"A-B-C"`
   - Each character is its own group
   - First group: `"A"`
   - Second group: `"B"`
   - Third group: `"C"`
   - Result: `"A-B-C"`
