# Minimum Genetic Mutation

## Problem
A gene string can be represented by an 8-character long string, with choices from `'A'`, `'C'`, `'G'`, and `'T'`.

Suppose we need to investigate a mutation from a gene string `start` to a gene string `end` where one mutation is defined as one single character changed in the gene string.

- For example, `"AACCGGTT"` -> `"AACCGGTA"` is one mutation.

There is also a gene bank `bank` that records all the valid gene mutations. A gene must be in the bank to be considered valid.

Given the two gene strings `start` and `end` and the gene bank `bank`, return _the minimum number of mutations needed to mutate from `start` to `end`_. If there is no such a mutation, return `-1`.

Note that the starting point is assumed to be valid, so it might not be included in the bank.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/min_genetic_mutation.xs`):** Contains the BFS solution logic

## Function Signature
- **Input:**
  - `start` (text): Starting gene string (8 characters, each A/C/G/T)
  - `end` (text): Target gene string (8 characters, each A/C/G/T)
  - `bank` (text[]): Array of valid gene strings
- **Output:**
  - (int): Minimum number of mutations needed, or `-1` if impossible

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| start: `"AACCGGTT"`, end: `"AACCGGTA"`, bank: `["AACCGGTA"]` | `1` |
| start: `"AACCGGTT"`, end: `"AAACGGTA"`, bank: `["AACCGGTA","AACCGCTA","AAACGGTA"]` | `2` |
| start: `"AAAAACCC"`, end: `"AACCCCCC"`, bank: `[]` | `-1` (empty bank) |
| start: `"AACCGGTT"`, end: `"AACCGGTT"`, bank: `["ANYTHING"]` | `0` (same start/end) |
| start: `"AACCGGTT"`, end: `"AAACGGTA"`, bank: `["AACCGGTA"]` | `-1` (end not reachable) |

**Explanation of Test Case 2:**
- Start: `"AACCGGTT"`
- Mutation 1: `"AACCGGTT"` -> `"AACCGGTA"` (change last T to A)
- Mutation 2: `"AACCGGTA"` -> `"AAACGGTA"` (change second A to A - actually change C to A at position 2)
- Total: 2 mutations
