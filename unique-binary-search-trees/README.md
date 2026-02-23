# Unique Binary Search Trees

## Problem

Given an integer `n`, return the number of **structurally unique BSTs** (binary search trees) which has exactly `n` nodes of unique values from `1` to `n`.

A binary search tree is considered unique if it has a different structure (shape), regardless of the values in the nodes. For example, with n=3, there are 5 structurally unique BSTs.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs (n = 0 through n = 5)
- **Function (`function/unique_binary_search_trees.xs`):** Contains the dynamic programming solution using Catalan numbers

## Function Signature

- **Input:**
  - `n` (int): Number of nodes (0 to n)
  - Constraints: n >= 0

- **Output:**
  - Returns (int): The number of structurally unique BSTs that can be formed with n nodes

## Algorithm Explanation

This problem is solved using **Catalan numbers** and dynamic programming.

For a BST with `n` nodes, we can choose any node `i` (from 1 to n) as the root:
- The left subtree will have `i-1` nodes (values 1 to i-1)
- The right subtree will have `n-i` nodes (values i+1 to n)

The recurrence relation is:
```
G(n) = Σ G(i-1) * G(n-i) for i from 1 to n
```

Where `G(n)` is the number of unique BSTs with n nodes.

Base cases:
- G(0) = 1 (empty tree)
- G(1) = 1 (single node)

## Test Cases

| Input (n) | Expected Output | Explanation |
|-----------|-----------------|-------------|
| 0 | 1 | Empty tree (edge case) |
| 1 | 1 | Single node tree |
| 2 | 2 | Two possible structures |
| 3 | 5 | Classic example with 5 unique trees |
| 4 | 14 | Catalan number C4 |
| 5 | 42 | Catalan number C5 |

## Catalan Numbers Sequence

The first few Catalan numbers are:
- C0 = 1
- C1 = 1
- C2 = 2
- C3 = 5
- C4 = 14
- C5 = 42
- C6 = 132
- ...

## Complexity Analysis

- **Time Complexity:** O(n²) - We compute G(2) through G(n), and each computation requires a sum over previous values
- **Space Complexity:** O(n) - We store the DP array of size n+1
