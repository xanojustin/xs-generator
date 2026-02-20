# LRU Cache

## Problem

Implement a **Least Recently Used (LRU) Cache** with the following requirements:

- The cache has a fixed capacity
- **get(key)** - Returns the value associated with the key if it exists, otherwise returns null. Accessing a key makes it the most recently used.
- **put(key, value)** - Inserts or updates the value for a key. Inserting a new item when at capacity evicts the least recently used item.

The LRU Cache is a classic data structure used in systems like database query caches, web page caches, and operating system memory management.

## Structure

- **Run Job (`run.xs`):** Calls the LRU Cache function with test operations
- **Function (`function/lru_cache.xs`):** Contains the LRU Cache implementation

## Function Signature

- **Input:**
  - `capacity` (int): Maximum number of items the cache can hold
  - `operations` (object[]): Array of operations to perform, each with:
    - `action` (text): Either "get" or "put"
    - `key` (text): The cache key
    - `value` (int?): Value to store (required for put operations)

- **Output:**
  - `operations` (object[]): Results of each operation
    - For get: `{ action, key, value }` (value is null if not found)
    - For put: `{ action, key, status }`
  - `final_cache_order` (text[]): Keys in cache from least to most recently used
  - `cache_contents` (object[]): Full cache contents

## Test Cases

| Operations | Capacity | Expected Result |
|------------|----------|-----------------|
| `[put(a,1), put(b,2), get(a), put(c,3), get(b)]` | 2 | a evicts b, get(b) returns null |
| `[put(x,10), get(x)]` | 1 | get returns 10 |
| `[]` (empty) | 2 | Empty cache state |
| `[put(a,1), put(a,2)]` | 2 | Value updated to 2 |
| `[get(nonexistent)]` | 2 | Returns null |

### Detailed Test Case Walkthrough

**Test Case 1: Basic eviction**
```
Capacity: 2
1. put(a, 1)    → Cache: [a]
2. put(b, 2)    → Cache: [a, b]
3. get(a)       → Returns 1, Cache: [b, a] (a is now most recent)
4. put(c, 3)    → Evicts b, Cache: [a, c]
5. get(b)       → Returns null (b was evicted)
```

**Test Case 2: Edge case - single capacity**
```
Capacity: 1
1. put(x, 10)   → Cache: [x]
2. get(x)       → Returns 10, Cache: [x]
```

**Test Case 3: Update existing key**
```
Capacity: 2
1. put(a, 1)    → Cache: [a]
2. put(a, 2)    → Updates a, Cache: [a] (value now 2)
```
