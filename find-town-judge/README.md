# Find the Town Judge

## Problem

In a town, there are `n` people labeled from `1` to `n`. There is a rumor that one of these people is secretly the town judge.

If the town judge exists, then:
1. The town judge trusts nobody.
2. Everybody (except the judge) trusts the town judge.
3. There is exactly one person that satisfies properties 1 and 2.

You are given an array `trust` where `trust[i] = [ai, bi]` represents that person `ai` trusts person `bi`. Return the label of the town judge if the town judge exists and can be identified, or return `-1` otherwise.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_town_judge.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `n` (int): The number of people in the town (labeled 1 to n)
  - `trust` (object[][]): Array of trust relationships where each element is [a, b] meaning person a trusts person b
- **Output:** (int) The label of the town judge, or -1 if no judge exists

## Approach

The solution uses a trust scoring system:
- For each trust relationship [a, b]: decrement a's score (they trust someone), increment b's score (they're trusted)
- The judge will have a score of exactly `n - 1` (trusted by all n-1 others, trusts nobody)

## Test Cases

| n | trust | Expected Output | Explanation |
|---|-------|-----------------|-------------|
| 2 | [[1, 2]] | 2 | Person 1 trusts person 2, so 2 is the judge |
| 3 | [[1, 3], [2, 3]] | 3 | Both 1 and 2 trust 3, so 3 is the judge |
| 3 | [[1, 3], [2, 3], [3, 1]] | -1 | Everyone trusts someone, no judge |
| 3 | [[1, 2], [2, 3]] | -1 | No one is trusted by everyone else |
| 1 | [] | 1 | Single person is automatically the judge |
| 4 | [[1, 3], [1, 4], [2, 3], [2, 4], [4, 3]] | 3 | 3 is trusted by 1, 2, and 4 |
