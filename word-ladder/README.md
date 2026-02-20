# Word Ladder

## Problem
Given two words, `begin_word` and `end_word`, and a dictionary `word_list`, find the length of the shortest transformation sequence from `begin_word` to `end_word`, such that:

1. Only one letter can be changed at a time
2. Each transformed word must exist in the `word_list`

Return `0` if there is no such transformation sequence.

## Example
- `begin_word` = "hit"
- `end_word` = "cog"
- `word_list` = ["hot", "dot", "dog", "lot", "log", "cog"]

One shortest transformation is: "hit" → "hot" → "dot" → "dog" → "cog"

Return: `5` (the number of words in the transformation sequence)

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/word_ladder.xs`):** Contains the BFS solution logic

## Function Signature
- **Input:**
  - `begin_word` (text): The starting word
  - `end_word` (text): The target word
  - `word_list` (text[]): Array of valid words for transformation
- **Output:**
  - Returns an `int` representing the length of the shortest transformation sequence, or `0` if no valid path exists

## Algorithm
This solution uses **Breadth-First Search (BFS)**:

1. First check if `end_word` exists in `word_list` (if not, return 0)
2. Initialize a queue with the starting word and step count of 1
3. Use a visited set to track processed words and avoid cycles
4. For each word in the queue:
   - If it matches `end_word`, return the current step count
   - Generate all possible words by changing one character at a time
   - For each valid new word (in word_list and not visited), add to queue
5. If queue is exhausted without finding end_word, return 0

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `begin_word`: "hit", `end_word`: "cog", `word_list`: ["hot", "dot", "dog", "lot", "log", "cog"] | 5 |
| `begin_word`: "hit", `end_word`: "cog", `word_list`: ["hot", "dot", "dog", "lot", "log"] | 0 (end_word not in list) |
| `begin_word`: "a", `end_word`: "c", `word_list`: ["a", "b", "c"] | 2 (direct: "a" → "c") |
| `begin_word`: "lost", `end_word`: "cost", `word_list`: ["most", "fost", "cost", "lost"] | 2 (single letter change) |
| `begin_word`: "hit", `end_word`: "cog", `word_list`: [] | 0 (empty list) |

## Complexity Analysis
- **Time Complexity:** O(N × M × 26) where N is the number of words in word_list and M is the length of each word
- **Space Complexity:** O(N) for the visited set and queue
