# Evaluate Division

## Problem

You are given an array of variable pairs `equations` and an array of real numbers `values`, where `equations[i] = [Ai, Bi]` and `values[i]` represent the equation `Ai / Bi = values[i]`. Each `Ai` or `Bi` is a string that represents a single variable.

You are also given some `queries`, where `queries[j] = [Cj, Dj]` represents the `jth` query where you must find the answer for `Cj / Dj = ?`.

Return the answers to all queries. If a single answer cannot be determined, return `-1.0`.

**Note:** The input is always valid. You may assume that evaluating the queries will not result in division by zero and that there is no contradiction.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs and logs results
- **Function (`function/evaluate_division.xs`):** Contains the Union-Find solution logic

## Function Signature

- **Input:**
  - `equations`: Array of variable pairs (text[][]) - Each pair [numerator, denominator]
  - `values`: Array of division results (decimal[]) - Each value corresponds to equations[i]
  - `queries`: Array of query pairs (text[][]) - Each pair [numerator, denominator] to evaluate
  
- **Output:**
  - Array of decimal values (decimal[]) - Results for each query, or -1.0 if cannot be determined

## Algorithm

This solution uses the **Union-Find (Disjoint Set Union)** data structure with weights:

1. **Build the graph:** Each variable is a node, each equation creates a weighted edge
2. **Union operation:** Connect variables with their division relationship as weight
3. **Find operation:** With path compression, tracks the cumulative weight from a node to its root
4. **Query evaluation:** Two variables can be divided if they share the same root; the result is the ratio of their weights to the root

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| equations: [[`"a"`, `"b"`], [`"b"`, `"c"`]], values: [2.0, 3.0], queries: [[`"a"`, `"c"`], [`"b"`, `"a"`], [`"a"`, `"e"`], [`"a"`, `"a"`], [`"x"`, `"x"`]] | [6.0, 0.5, -1.0, 1.0, -1.0] |
| equations: [], values: [], queries: [[`"a"`, `"b"`]] | [-1.0] |
| equations: [[`"a"`, `"b"`]], values: [0.5], queries: [[`"a"`, `"b"`], [`"b"`, `"a"`], [`"a"`, `"a"`]] | [0.5, 2.0, 1.0] |

### Explanation of Test Cases

**Test 1 (Basic):**
- Given: a/b = 2.0, b/c = 3.0
- a/c = a/b * b/c = 2.0 * 3.0 = 6.0
- b/a = 1 / (a/b) = 1 / 2.0 = 0.5
- a/e = -1.0 (e not in equations)
- a/a = 1.0 (same variable)
- x/x = -1.0 (x not in equations)

**Test 2 (Empty):**
- No equations provided, so no variable relationships known
- All queries return -1.0

**Test 3 (Single):**
- a/b = 0.5
- b/a = 1/0.5 = 2.0
- a/a = 1.0
