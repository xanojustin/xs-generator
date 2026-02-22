# Count and Say

## Problem
The **count-and-say** sequence is a sequence of digit strings defined by the recursive formula:
- The first term is `"1"`
- Each subsequent term is built by "reading" the previous term aloud, counting the number of digits in groups of the same digit

For example:
- `1` → `"1"` (one 1)
- `2` → `"11"` (two 1s)
- `3` → `"21"` (one 2, then one 1)
- `4` → `"1211"` (one 1, one 2, two 1s)
- `5` → `"111221"` (one 1, one 2, two 1s, two 2s, one 1)

Given a positive integer `n`, return the nth term of the count-and-say sequence.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input (n=5)
- **Function (`function/count_and_say.xs`):** Contains the solution logic that iteratively builds each term

## Function Signature
- **Input:**
  - `n` (int): The term number to generate (1-indexed)
- **Output:**
  - (text): The nth term of the count-and-say sequence as a string

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 1 | `"1"` | Base case - the sequence starts with "1" |
| 4 | `"1211"` | One 1, one 2, two 1s |
| 5 | `"111221"` | One 1, one 2, two 1s |
| 6 | `"312211"` | Three 1s, two 2s, one 1 |
| 0 | `""` | Edge case - invalid input returns empty string |
| 8 | `"1113213211"` | Larger term - tests algorithm efficiency |

## Algorithm Explanation
The solution uses an iterative approach:
1. Start with the first term `"1"`
2. For each subsequent term, scan the current term left to right
3. Count consecutive identical digits
4. Build the next term by appending each count followed by its digit
5. Repeat until reaching the nth term

Time Complexity: O(n × m) where n is the input number and m is the maximum length of any intermediate string
Space Complexity: O(m) for storing the current and next terms
