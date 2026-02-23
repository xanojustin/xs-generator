# Compare Version Numbers

## Problem
Compare two version numbers `version1` and `version2`.

- If `version1` > `version2`, return `1`
- If `version1` < `version2`, return `-1`
- Otherwise, return `0`

Version numbers are strings consisting of numeric segments separated by dots (e.g., `"1.0.3"`). Leading zeros in each segment are ignored when comparing (e.g., `"001"` equals `"1"`).

You may assume that the version strings are non-empty and contain only digits and the `.` character.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/compare_versions.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `version1` (text): First version number string
  - `version2` (text): Second version number string
- **Output:** 
  - (int): Returns `1` if version1 > version2, `-1` if version1 < version2, `0` if equal

## Algorithm
1. Split both version strings by `.` to get arrays of segments
2. Determine the maximum number of segments between the two versions
3. Iterate through each position up to the maximum length:
   - If one version has no segment at this position, treat it as `0`
   - Convert each segment to integer (automatically handles leading zeros)
   - Compare the segments numerically
   - If segments differ, return the comparison result
4. If all segments are equal, return `0`

## Test Cases

| version1 | version2 | Expected Output |
|----------|----------|-----------------|
| `"1.2.3"` | `"1.2.4"` | `-1` |
| `"1.2.3"` | `"1.2.2"` | `1` |
| `"1.2.3"` | `"1.2.3"` | `0` |
| `"1.0"` | `"1"` | `0` |
| `"1.0.0.0"` | `"1"` | `0` |
| `"0.1"` | `"1.0"` | `-1` |
| `"1.2.3.4"` | `"1.2.3"` | `1` |
| `"001.002"` | `"1.2"` | `0` |
| `"1.10"` | `"1.2"` | `1` (numeric comparison, not lexical) |

## XanoScript Features Demonstrated
- String splitting with `split:'.'` filter
- Array operations with `count` filter
- Type conversion with `to_int` filter
- While loops with compound conditions using `&&`
- Array indexing with `$array[$index]`
- Conditional blocks with `if`/`elseif`
