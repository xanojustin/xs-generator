# LFU Cache

## Problem

Design and implement a data structure for a **Least Frequently Used (LFU) Cache**.

The LFU cache should support:
- `get(key)` - Get the value of the key if it exists in the cache, otherwise return `null`. Increment the access frequency of this key.
- `put(key, value)` - Insert or update the value of the key. If the key already exists, update its value and increment its frequency. If the key doesn't exist and the cache is at capacity, evict the least frequently used key before inserting the new key.

**Eviction Policy:**
- When the cache reaches capacity and a new item needs to be added, evict the **least frequently used** item
- If there is a tie (multiple items with the same lowest frequency), evict the **least recently used** among them

## Structure

- **Run Job (`run.xs`):** Calls the LFU cache function with test operations
- **Function (`function/lfu_cache.xs`):** Contains the LFU cache implementation logic

## Function Signature

**Input:**
- `capacity` (int): Maximum number of items the cache can hold
- `operations` (object[]): Array of operations to perform, where each operation has:
  - `action` (text): Either `"get"` or `"put"`
  - `key` (text): The cache key
  - `value` (int?, optional): The value to store (only for `put` operations)

**Output:**
- `operations` (object[]): Results of each operation performed
  - For `put`: `{ action: "put", key, status: "success" }`
  - For `get`: `{ action: "get", key, value }` (value is `null` if key not found)
- `final_cache_state` (object[]): Current cache contents with key, value, and frequency for each item

## Test Cases

| Operations | Capacity | Expected Behavior |
|------------|----------|-------------------|
| `put(a,1)`, `put(b,2)`, `get(a)`, `put(c,3)`, `get(b)` | 2 | Returns `[1, null]` - `b` evicted because `a` has freq 2, `b` has freq 1 |
| `put(a,1)`, `put(b,2)`, `get(a)`, `get(a)`, `put(c,3)` | 2 | Returns `[1, 1, null]` - `b` evicted (freq 1 vs `a`'s freq 3) |
| `put(a,1)`, `get(b)` | 2 | Returns `[null]` - key `b` not found |
| (empty operations) | 2 | Returns empty results, empty cache |
| `put(a,1)`, `put(a,2)` | 1 | Updates value of `a` to 2, frequency increases |

## Example Trace

```
Capacity: 2
Operations:
1. put(a, 1)    → Cache: [a:1(freq=1)]
2. put(b, 2)    → Cache: [a:1(freq=1), b:2(freq=1)]
3. get(a)       → Returns 1, Cache: [b:2(freq=1), a:1(freq=2)]  (a's freq increased)
4. put(c, 3)    → Evicts b (freq=1 < a's freq=2), Cache: [a:1(freq=2), c:3(freq=1)]
5. get(b)       → Returns null (b was evicted)
```
