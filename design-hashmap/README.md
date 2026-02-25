# Design HashMap

## Problem
Design a HashMap without using any built-in hash table libraries.

Implement the `MyHashMap` class:

- `put(key, value)` inserts a `(key, value)` pair into the HashMap. If the `key` already exists in the map, update the corresponding `value`.
- `get(key)` returns the `value` to which the specified `key` is mapped, or `-1` if this map contains no mapping for the `key`.
- `remove(key)` removes the `key` and its corresponding `value` if the map contains the mapping for the `key`.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/design_hashmap.xs`):** Contains the HashMap implementation using separate chaining for collision resolution

## Function Signature
- **Input:**
  - `operation` (text): Operation to perform - "put", "get", or "remove"
  - `key` (int): Key for the operation
  - `value` (int): Value for put operation (optional, required only for put)
  - `hashmap` (object): Current state of the hashmap containing `buckets` array (optional)
- **Output:**
  - (object): Object containing:
    - `hashmap`: Updated hashmap state with `buckets` array
    - `result`: Result of the operation (value for get/put, true for remove, -1 for not found)

## Test Cases

| Operation | Input | Expected Output |
|-----------|-------|-----------------|
| put | `key: 1, value: 10` | `result: 10`, hashmap updated |
| put | `key: 2, value: 20` | `result: 20`, hashmap updated |
| get | `key: 1` | `result: 10` |
| get | `key: 3` | `result: -1` (not found) |
| put | `key: 1, value: 30` | `result: 30` (updates existing) |
| get | `key: 1` | `result: 30` (updated value) |
| remove | `key: 2` | `result: true` |
| get | `key: 2` | `result: -1` (removed) |

## Algorithm
This solution uses **separate chaining** for collision resolution:
1. Use an array of 1000 buckets
2. Hash function: `key % 1000` (with adjustment for negative keys)
3. Each bucket is an array of `{key, value}` entries
4. For collisions, entries are stored sequentially in the same bucket

**Operations:**
- **put**: Calculate bucket index, search for existing key, update or append
- **get**: Calculate bucket index, search for key, return value or -1
- **remove**: Calculate bucket index, find key, remove entry from bucket

**Time Complexity:**
- Average case: O(1) for all operations
- Worst case: O(n) when all keys collide to same bucket

**Space Complexity:** O(n) where n is the number of stored key-value pairs
