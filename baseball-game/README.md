# Baseball Game

## Problem
You are keeping score for a baseball game with strange rules. The game consists of several rounds, where the scores of past rounds may affect future rounds' scores.

You are given a list of strings `operations`, where `operations[i]` is the `ith` operation you must apply to the record. The operations are:

- An integer `x` - Record a new score of `x`
- `"C"` - Invalidate the previous score, removing it from the record
- `"D"` - Record a new score that is double the previous score
- `"+"` - Record a new score that is the sum of the previous two scores

Return the sum of all the scores on the record after applying all the operations.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/calculate_score.xs`):** Contains the solution logic

## Function Signature
- **Input:** `text[] operations` - An array of strings representing operations
  - Integer values (as text) to add to scores
  - `"C"` to cancel/remove the last score
  - `"D"` to double the last score and add it
  - `"+"` to add the sum of the last two scores
- **Output:** `int` - The total sum of all valid scores

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `["5", "2", "C", "D", "+"]` | `30` | 5→record, 2→record, C→remove 2, D→double 5=10, +→5+10=15. Total: 5+10+15=30 |
| `["1", "2", "3"]` | `6` | Simple addition: 1+2+3=6 |
| `["C"]` | `0` | Edge case: Cancel with no scores results in 0 |
| `["10", "D", "D", "D"]` | `150` | 10 + 20 + 40 + 80 = 150 (exponential doubling) |
