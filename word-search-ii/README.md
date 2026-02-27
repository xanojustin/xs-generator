# Word Search II

## Problem
Given an `m x n` board of characters and a list of words, find all words that exist in the board.

Words can be constructed from letters of sequentially adjacent cells (horizontally or vertically neighboring). The same letter cell may not be used more than once in a word.

### Constraints
- The board consists of lowercase English letters only
- All words consist of lowercase English letters only
- Words may share common prefixes
- Each word can be found at most once in the result

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/word_search_ii.xs`):** Contains the solution logic using Trie + DFS

## Function Signature
- **Input:**
  - `board` (text[]): Array of strings representing the 2D board. Each string is a row.
  - `words` (text[]): Array of words to search for
- **Output:**
  - `text[]`: Array of words found in the board (order not guaranteed)

## Algorithm
This solution uses a **Trie (Prefix Tree)** combined with **Depth-First Search (DFS)**:

1. **Build Trie:** Insert all words into a Trie for efficient prefix matching
2. **DFS from each cell:** For each cell in the board, explore all paths that match prefixes in the Trie
3. **Backtracking:** Track visited cells by path string to prevent reuse within a single word search
4. **Collect results:** When reaching a Trie node that marks the end of a word, add it to results

This approach is much more efficient than checking each word independently against the board, especially when words share common prefixes.

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `board: ["oath","etan","ihrg","tflv"]`<br>`words: ["oath","eat"]` | `["oath","eat"]` |
| `board: ["ab","cd"]`<br>`words: ["abc","abd","ace"]` | `[]` |
| `board: []`<br>`words: ["word"]` | `[]` |
| `board: ["a"]`<br>`words: ["a","b"]` | `["a"]` |
| `board: ["aa"]`<br>`words: ["aaa"]` | `[]` |

### Test Case Explanations
1. **Basic case:** Both "oath" and "eat" can be found in the board following adjacent cells
2. **No matches:** Words are longer than possible paths or don't match board letters
3. **Empty board:** Edge case - empty board returns empty results
4. **Single cell:** Can match single-letter words, but not words requiring more cells
5. **Not enough letters:** Word needs 3 'a's but board only has 2 cells

## Example Walkthrough

Board:
```
o a t h
e t a n
i h r g
t f l v
```

- "oath": o(0,0) → a(0,1) → t(0,2) → h(0,3) ✓
- "eat": e(1,0) → a(1,2) → t(0,2) ✓ (can go diagonal implicitly via adjacency)

Note: In this implementation, we search all 4 directions (up, down, left, right) from each cell.
