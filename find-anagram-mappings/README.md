# Find Anagram Mappings

## Problem

Given two integer lists `nums1` and `nums2` where `nums2` is an anagram of `nums1`, find an index mapping array `mapping` from `nums1` to `nums2`.

A mapping `mapping[i] = j` means the ith element in `nums1` appears in `nums2` at index `j`.

If there are multiple valid answers, return any of them. The lists are guaranteed to be anagrams of each other.

## Structure

- **Run Job (`run.xs`):** Calls the test_runner function which executes all test cases
- **Function (`function/find_anagram_mappings.xs`):** Contains the solution logic
- **Function (`function/test_runner.xs`):** Runs multiple test cases and logs results

## Function Signature

- **Input:** 
  - `nums1` (int[]): First list of integers
  - `nums2` (int[]): Second list (anagram of nums1)
- **Output:** 
  - `int[]`: Index mapping from nums1 to nums2

## Approach

1. Build a hash map (object) that maps each unique value in `nums2` to a list of indices where it appears
2. For each element in `nums1`, look up its indices in the map
3. Take the first available index and add it to the result
4. Remove the used index from the map (to handle duplicates correctly)

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `nums1=[12,28,46,32,50], nums2=[50,12,32,46,28]` | `[1,4,3,2,0]` |
| `nums1=[1,2], nums2=[2,1]` | `[1,0]` |
| `nums1=[1,2,1], nums2=[2,1,1]` | `[1,0,2]` or `[2,0,1]` |
| `nums1=[42], nums2=[42]` | `[0]` |
| `nums1=[5,5,5,5], nums2=[5,5,5,5]` | `[0,1,2,3]` |

### Test Case Descriptions

1. **Basic:** Standard case with unique values
2. **Simple swap:** Two elements swapped
3. **With duplicates:** Handles repeated values correctly
4. **Single element:** Edge case with just one element
5. **All same:** All elements identical (tests proper index management)
