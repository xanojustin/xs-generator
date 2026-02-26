# Sock Merchant

## Problem
John works at a clothing store. He has a large pile of socks that he must pair by color for sale. Given an array of integers representing the color of each sock, determine how many pairs of socks with matching colors there are.

For example, if there are 7 socks with colors `[1, 2, 1, 2, 1, 3, 2]`, there are:
- Three socks of color 1 (1 pair)
- Three socks of color 2 (1 pair)  
- One sock of color 3 (0 pairs)

So the function should return **2** pairs total.

## Structure
- **Run Job (`run.xs`):** Calls the `sock_merchant` function with test inputs
- **Function (`function/sock_merchant.xs`):** Contains the solution logic using a frequency map to count pairs

## Function Signature
- **Input:** `int[] socks` - An array of integers where each integer represents a sock color
- **Output:** `int` - The total number of matching pairs of socks

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[1, 2, 1, 2, 1, 3, 2]` | `2` |
| `[10, 20, 20, 10, 10, 30, 50, 10, 20]` | `3` |
| `[]` | `0` |
| `[1, 1, 1, 1]` | `2` |
| `[5]` | `0` |
| `[1, 2, 3, 4, 5]` | `0` |

### Explanation of Test Cases
1. **Basic case:** Mixed colors with multiple pairs
2. **Multiple pairs:** Three pairs total (two 10s, two 20s, and one more 10 pair)
3. **Edge case:** Empty array returns 0
4. **All same color:** Four socks of same color = 2 pairs
5. **Single element:** One sock can't make a pair
6. **No pairs:** All different colors = 0 pairs

## Algorithm
1. Create a frequency map to count occurrences of each sock color
2. Iterate through the socks array and populate the frequency map
3. For each color count in the map, divide by 2 (integer division) to get pairs
4. Sum all pairs and return the total
