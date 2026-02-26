# Defanging an IP Address

## Problem
Given a valid (IPv4) IP address, return a defanged version of that IP address.

A defanged IP address replaces every period "." with "[.]".

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/defang_ip.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `address` (text): A valid IPv4 address string (e.g., "1.1.1.1", "255.100.50.0")
- **Output:** 
  - (text): The defanged IP address with all "." replaced by "[.]"

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `"1.1.1.1"` | `"1[.]1[.]1[.]1"` |
| `"255.100.50.0"` | `"255[.]100[.]50[.]0"` |
| `"192.168.0.1"` | `"192[.]168[.]0[.]1"` |
| `"0.0.0.0"` | `"0[.]0[.]0[.]0"` |
| `"127.0.0.1"` | `"127[.]0[.]0[.]1"` |

## Examples

**Example 1:**
- Input: `address = "1.1.1.1"`
- Output: `"1[.]1[.]1[.]1"`

**Example 2:**
- Input: `address = "255.100.50.0"`
- Output: `"255[.]100[.]50[.]0"`

## Notes
- The input is always a valid IPv4 address
- This is useful for safely displaying IP addresses in contexts where plain dots might be interpreted (e.g., email, logging)
