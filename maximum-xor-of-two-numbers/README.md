# Maximum XOR of Two Numbers in an Array

## Problem

Given an integer array `nums`, return the maximum result of `nums[i] XOR nums[j]`, where `0 <= i <= j < n`.

This is a classic bitwise problem that can be solved using a trie (prefix tree) data structure. The key insight is that to maximize XOR, we want to find pairs of numbers that have opposite bits at the highest possible positions.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/maximum_xor.xs`):** Contains the solution logic using a trie-based approach

## Function Signature

- **Input:**
  - `nums` (int[]): An array of integers
- **Output:**
  - `max_xor` (int): The maximum XOR value of any two numbers in the array

## Approach

The solution uses a bitwise trie (prefix tree) where each number is represented by its binary form (up to 31 bits for positive integers). For each number:
1. Insert its binary representation into the trie
2. Simultaneously query the trie for the number that would produce the maximum XOR with the current number
3. Track the maximum XOR found

The trie allows us to efficiently find, for each bit position, whether we can take the opposite bit (which maximizes XOR at that position).

## Test Cases

| Input | Expected Output | Explanation |
|-------|-----------------|-------------|
| `[3, 10, 5, 25, 2, 8]` | `28` | 5 XOR 25 = 28 (binary: 00101 XOR 11001 = 11100) |
| `[0]` | `0` | Only one element, XOR with itself is 0 |
| `[2, 4]` | `6` | 2 XOR 4 = 6 (binary: 010 XOR 100 = 110) |
| `[8, 1, 2]` | `10` | 8 XOR 2 = 10 (binary: 1000 XOR 0010 = 1010) |
| `[14, 70, 53, 83, 49, 91, 36, 80, 92, 51, 66, 70]` | `127` | 91 XOR 36 = 127 |
