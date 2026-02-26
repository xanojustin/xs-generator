# Counting Valleys

## Problem

Gary is an avid hiker. He tracks his hikes meticulously, paying close attention to small details like topography. During his last hike, he took exactly n steps. For every step he took, he noted if it was an uphill, U, or a downhill, D step. Gary's hikes start and end at sea level, and each step up or down represents a 1 unit change in altitude.

A mountain is a sequence of consecutive steps above sea level, starting with a step up from sea level and ending with a step down to sea level.

A valley is a sequence of consecutive steps below sea level, starting with a step down from sea level and ending with a step up to sea level.

Given a sequence of up and down steps during Gary's hike, find and return the number of valleys he walked through.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/counting_valleys.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `steps` (text): A string consisting of characters 'U' (uphill) and 'D' (downhill)
  
- **Output:**
  - (int): The number of valleys traversed during the hike

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `"UDDDUDUU"` | `1` | The hiker goes: up, down, down, down (valley starts), up, down, up (valley ends), up, up. One valley traversed. |
| `"DDUUDDUDUUUD"` | `2` | Two separate valleys traversed |
| `"UUDD"` | `0` | Goes up into mountain, back down - no valley |
| `"DDUU"` | `1` | Goes down into valley, back up - one valley |
| `""` (empty) | `0` | Edge case: no steps, no valleys |
| `"UD"` | `0` | Edge case: one up, one down - back at sea level but no valley (never went below) |
| `"DU"` | `1` | Edge case: one down, one up - one valley |

## Example Walkthrough

For input `"UDDDUDUU"`:
1. Step 1: 'U' → elevation = 1 (above sea level)
2. Step 2: 'D' → elevation = 0 (back to sea level)
3. Step 3: 'D' → elevation = -1 (below sea level, valley starts)
4. Step 4: 'D' → elevation = -2 (deeper in valley)
5. Step 5: 'U' → elevation = -1 (still in valley)
6. Step 6: 'D' → elevation = -2 (deeper again)
7. Step 7: 'U' → elevation = -1 (still in valley)
8. Step 8: 'U' → elevation = 0 (back to sea level, valley ends)

Result: **1 valley**
