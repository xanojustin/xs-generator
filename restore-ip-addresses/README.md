# Restore IP Addresses

## Problem
Given a string `digits` containing only digits, return all possible valid IP addresses that can be formed by inserting dots into the string.

A valid IP address consists of exactly four integers (each between 0 and 255) separated by single dots. No leading zeros are allowed unless the number is exactly "0".

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/restore_ip_addresses.xs`):** Contains the solution logic using iterative backtracking

## Function Signature
- **Input:**
  - `digits` (text): A string containing only digits, with length between 4 and 12
- **Output:**
  - `text[]`: An array of all valid IP addresses that can be formed

## Algorithm
This solution uses **iterative backtracking** (depth-first search with an explicit stack) because XanoScript doesn't support direct recursion. The algorithm:

1. Validates that input length is between 4 and 12 digits
2. Uses a stack to track states: current position in string and segments collected so far
3. For each state, tries segments of length 1-3 (if valid)
4. Validates each segment:
   - No leading zeros ("0" is valid, "01" is not)
   - Value must be 0-255
5. When 4 segments are collected and all digits are used, forms a valid IP

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"25525511135"` | `["255.255.11.135", "255.255.111.35"]` |
| `"0000"` | `["0.0.0.0"]` |
| `"101023"` | `["1.0.10.23", "1.0.102.3", "10.1.0.23", "10.10.2.3", "101.0.2.3"]` |
| `"1111"` | `["1.1.1.1"]` |
| `"12345"` | `["1.2.3.45", "1.2.34.5", "1.23.4.5", "12.3.4.5"]` |

### Edge Cases
- **Minimum input:** `"0000"` → `["0.0.0.0"]` (all zeros is valid)
- **Maximum single segment:** `"255255255255"` → `["255.255.255.255"]`
- **No valid IPs:** `"1234567890123"` (too long, fails validation)

## Complexity Analysis
- **Time Complexity:** O(3^4) = O(81) - At most 3 choices for each of 4 segments
- **Space Complexity:** O(4) = O(1) - Stack depth is bounded by 4 segments
