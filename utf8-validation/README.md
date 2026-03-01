# UTF-8 Validation

## Problem
Given an array of integers representing bytes, determine if the array represents a valid UTF-8 encoding.

UTF-8 encoding rules:
- **1-byte character:** `0xxxxxxx` (0-127) - ASCII characters
- **2-byte character:** `110xxxxx 10xxxxxx` (192-223 followed by 128-191)
- **3-byte character:** `1110xxxx 10xxxxxx 10xxxxxx` (224-239 followed by two 128-191 bytes)
- **4-byte character:** `11110xxx 10xxxxxx 10xxxxxx 10xxxxxx` (240-247 followed by three 128-191 bytes)

Continuation bytes (bytes after the first in a multi-byte sequence) must:
- Start with `10xxxxxx` pattern (values 128-191)

Invalid start bytes include:
- Values 128-191 (these are continuation bytes, cannot start a character)
- Values 248-255 (invalid UTF-8 byte ranges)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/utf8_validation.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `data` (int[]): Array of integers representing bytes (0-255)
- **Output:** 
  - `bool`: `true` if the data represents valid UTF-8 encoding, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[197, 130, 1]` | `true` (valid 2-byte char followed by 1-byte char) |
| `[235, 140, 4]` | `false` (invalid continuation byte - 4 is not 128-191) |
| `[0]` | `true` (valid single ASCII character) |
| `[255]` | `false` (invalid start byte - 255 > 247) |
| `[145]` | `false` (continuation byte used as start) |
| `[230, 136, 145]` | `true` (valid 3-byte character) |
| `[240, 162, 138, 147]` | `true` (valid 4-byte character) |
| `[237, 160, 128]` | `true` (valid 3-byte character in surrogate range) |
