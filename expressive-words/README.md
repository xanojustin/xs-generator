# Expressive Words

## Problem
Sometimes people repeat letters to represent extra feeling in text. For example:
- "hello" might become "heeellooo" (extended e's and o's)
- "hi" might become "hiiii" (extended i's)

We call a word **expressive** or "stretchy" if it can be transformed into the target word by extending some groups of characters. A group is a maximal consecutive sequence of the same character.

### Rules for a stretchy word:
1. The word must have the same groups of characters as the target, in the same order
2. For each corresponding group:
   - If the target group has length **≥ 3**, the word's group can be any length from 1 up to the target's length
   - If the target group has length **< 3** (1 or 2), the word's group must match exactly

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs and logs results
- **Function (`function/expressive_words.xs`):** Contains the solution logic

## Function Signature
- **Input:**
  - `target` (text): The expressive target word with potential stretches (e.g., "heeellooo")
  - `words` (text[]): Array of query words to check against the target
- **Output:**
  - (int): The count of words that are stretchy versions of the target

## Example

**Target:** `heeellooo`  
**Groups:** h(1), e(3), l(2), o(3)

| Query Word | Groups | Stretchy? | Reason |
|------------|--------|-----------|--------|
| hello | h(1), e(1), l(2), o(1) | ✅ Yes | e(1)≤3, o(1)≤3 (target groups ≥3) |
| hi | h(1), i(1) | ❌ No | Different group structure (no 'i' in target) |
| heello | h(1), e(2), l(2), o(1) | ❌ No | e(2)≠3 (target e group <3 required exact match) |

## Test Cases

| Target | Words | Expected Output |
|--------|-------|-----------------|
| `heeellooo` | `["hello", "hi", "heello"]` | `1` |
| `hello` | `[]` | `0` |
| `zzzz` | `["zz", "zzz", "zzzz"]` | `3` |
| `aaaaa` | `["a", "aa", "aaa", "aaaa", "aaaaa"]` | `5` |

### Test Case Explanations

1. **Basic case:** Only "hello" can stretch to "heeellooo" - "hi" has wrong letters, "heello" has e(2) which doesn't match target e(3) exactly
2. **Edge case:** Empty input returns 0
3. **Multiple valid:** All words with 'z' repeated up to 4 times are valid since target z(4) ≥ 3
4. **Single group:** All variations valid since single character group can stretch freely

## Algorithm

1. Parse the target word into groups of (character, count)
2. For each query word:
   - Parse into groups
   - If group count differs from target, skip
   - For each group pair, check:
     - Characters match
     - Word's count ≤ target's count
     - If target count < 3, word's count must equal target's count
3. Count words that pass all checks
