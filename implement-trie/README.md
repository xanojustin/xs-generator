# Implement Trie (Prefix Tree)

## Problem

Implement a **Trie** (also known as a prefix tree), which is a tree-like data structure that stores a dynamic set of strings. It is commonly used for efficient retrieval of keys in a dataset of strings.

The Trie should support the following operations:
- **insert(word)**: Inserts the string `word` into the trie.
- **search(word)**: Returns `true` if the string `word` is in the trie (i.e., was inserted before), and `false` otherwise.
- **startsWith(prefix)**: Returns `true` if there is a previously inserted string `word` that has the prefix `prefix`, and `false` otherwise.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs to verify all operations work correctly
- **Function (`function/implement_trie.xs`):** Contains the complete Trie implementation with insert, search, and startsWith methods

## Function Signature

- **Input:**
  - `operations`: An array of strings representing the operations to perform (`"insert"`, `"search"`, `"startsWith"`)
  - `inputs`: An array where each element is an object containing the input for the corresponding operation
    - For `"insert"`: `{ "word": string }`
    - For `"search"`: `{ "word": string }`
    - For `"startsWith"`: `{ "prefix": string }`

- **Output:** An array of boolean results (only `search` and `startsWith` operations return values; `insert` returns `null`)

## Test Cases

| Operations | Inputs | Expected Output |
|------------|--------|-----------------|
| `["insert", "search"]` | `[{"word": "apple"}, {"word": "apple"}]` | `[null, true]` |
| `["insert", "search", "search", "startsWith"]` | `[{"word": "apple"}, {"word": "apple"}, {"word": "app"}, {"prefix": "app"}]` | `[null, true, false, true]` |
| `["search"]` (empty trie) | `[{"word": "hello"}]` | `[false]` |
| `["insert", "insert", "search", "startsWith"]` | `[{"word": "a"}, {"word": "ab"}, {"word": "ab"}, {"prefix": "a"}]` | `[null, null, true, true]` |
| `["startsWith"]` (empty trie) | `[{"prefix": "xyz"}]` | `[false]` |

### Edge Cases Covered
- Empty trie operations (search/startsWith on empty trie return false)
- Single character words
- Prefix that is itself a word (e.g., "app" is a prefix of "apple", but may not be inserted)
- Words that are prefixes of other words
- Multiple words sharing common prefixes
