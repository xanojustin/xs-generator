# Raindrops

## Problem

Convert a number to a string based on its factors.

The rules of raindrops are:
- If the number has 3 as a factor, output **"Pling"**
- If the number has 5 as a factor, output **"Plang"**
- If the number has 7 as a factor, output **"Plong"**
- If the number does not have any of 3, 5, or 7 as a factor, just pass the number's digits straight through

Multiple factors combine their sounds. For example:
- 15 has factors 3 and 5, so it outputs "PlingPlang"
- 105 has factors 3, 5, and 7, so it outputs "PlingPlangPlong"

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/raindrops.xs`):** Contains the solution logic

## Function Signature

- **Input:** 
  - `number` (int, required): A positive integer to convert
- **Output:** 
  - Returns `text`: The raindrop sound string or the number as text

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| 1 | "1" | No factors of 3, 5, or 7 |
| 3 | "Pling" | Has factor 3 |
| 5 | "Plang" | Has factor 5 |
| 7 | "Plong" | Has factor 7 |
| 15 | "PlingPlang" | Has factors 3 and 5 |
| 21 | "PlingPlong" | Has factors 3 and 7 |
| 35 | "PlangPlong" | Has factors 5 and 7 |
| 105 | "PlingPlangPlong" | Has factors 3, 5, and 7 |
| 8 | "8" | No factors of 3, 5, or 7 |
