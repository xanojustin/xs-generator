# Assign Cookies

## Problem
You are a parent who wants to give your children cookies. Each child `i` has a **greed factor** `g[i]`, which is the minimum size of a cookie that the child will be content with. Each cookie `j` has a size `s[j]`. If `s[j] >= g[i]`, we can assign the cookie `j` to the child `i`, and the child will be content.

Your goal is to **maximize the number of satisfied children** and return that maximum number.

### Constraints:
- Each child can receive at most one cookie
- Each cookie can be given to at most one child
- You have limited cookies, so you must assign them optimally

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/assign_cookies.xs`):** Contains the solution logic using a greedy algorithm

## Function Signature
- **Input:**
  - `greed_factors` (int[]): Greed factor of each child (minimum cookie size needed to satisfy them)
  - `cookie_sizes` (int[]): Size of each available cookie
- **Output:**
  - `satisfied` (int): Maximum number of children that can be satisfied

## Algorithm
The solution uses a **greedy approach**:
1. Sort both the greed factors and cookie sizes in ascending order
2. Use two pointers to track the current child and current cookie
3. For each child, find the smallest cookie that satisfies them
4. If a cookie satisfies the child, both pointers advance and count increases
5. If a cookie is too small, only the cookie pointer advances
6. Continue until we run out of children or cookies

**Time Complexity:** O(n log n + m log m) for sorting, where n = number of children, m = number of cookies  
**Space Complexity:** O(1) extra space (sorting may use O(log n) stack space)

## Test Cases

| greed_factors | cookie_sizes | Expected Output | Explanation |
|---------------|--------------|-----------------|-------------|
| [1, 2, 3] | [1, 1] | 1 | One cookie (size 1) satisfies child with greed 1. Second cookie (size 1) is too small for greed 2. |
| [1, 2] | [1, 2, 3] | 2 | Both children can be satisfied with cookies 1 and 2 |
| [1, 2, 3] | [3] | 1 | Only one cookie (size 3), satisfies child with greed 3 |
| [] | [1, 2, 3] | 0 | No children to satisfy |
| [1, 2, 3] | [] | 0 | No cookies available |
| [2, 2, 2] | [1, 1, 1] | 0 | No cookie is large enough |
| [1, 2, 3, 4, 5] | [1, 2, 3, 4, 5] | 5 | Perfect match - all children satisfied |
