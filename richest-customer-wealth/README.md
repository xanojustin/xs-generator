# Richest Customer Wealth

## Problem
You are given an `m x n` integer grid `accounts` where `accounts[i][j]` is the amount of money the `i`-th customer has in the `j`-th bank account.

Return the **wealth** that the richest customer has.

A customer's **wealth** is the amount of money they have in all their bank accounts. The richest customer is the customer that has the maximum wealth.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/richest_customer_wealth.xs`):** Contains the solution logic

## Function Signature
- **Input:** 
  - `accounts` (int[][]): A 2D array where each inner array represents a customer's bank account balances
- **Output:** 
  - (int): The maximum wealth among all customers

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `[[1, 2, 3], [3, 2, 1]]` | `6` |
| `[[1, 5], [7, 3], [3, 5]]` | `10` |
| `[[5]]` | `5` |
| `[[0, 0, 0]]` | `0` |
| `[[100, 200, 300, 400], [500, 600, 700, 800]]` | `2600` |

### Explanation of Test Cases
1. **Basic case:** Both customers have wealth = 6, so maximum is 6
2. **Different wealths:** Customer 0 has 6, Customer 1 has 10, Customer 2 has 8 → max is 10
3. **Single customer, single bank:** Only one customer with one account
4. **Zero wealth:** Customer with no money
5. **Large numbers:** Testing with larger values to ensure proper integer handling
