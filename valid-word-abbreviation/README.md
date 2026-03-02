# Valid Word Abbreviation

## Problem
Given a non-empty string `word` and an abbreviation `abbr`, return whether the string matches the abbreviation.

A string such as `"internationalization"` can be abbreviated as `"i12iz4n"` where numbers represent the count of letters skipped. For example:
- `"i12iz4n"` → `"i"` + 12 skipped letters + `"iz"` + 4 skipped letters + `"n"`

**Rules:**
- Numbers must represent a positive count of skipped characters
- Leading zeros in numbers are not allowed (e.g., `"01"` is invalid)
- Letters in the abbreviation must match the corresponding letters in the word exactly
- The abbreviation must consume the entire word (no partial matches)

## Structure
- **Run Job (`run.xs`):** Entry point that calls the test harness function
- **Function (`function/valid_word_abbreviation.xs`):** Contains the solution logic that validates if an abbreviation matches a word
- **Test Function (`function/test_valid_word_abbreviation.xs`):** Runs multiple test cases and logs results

## Function Signature
- **Input:**
  - `word` (text): The original word to check against
  - `abbr` (text): The abbreviation to validate
- **Output:** (bool): `true` if the abbreviation is valid for the given word, `false` otherwise

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| word: `"internationalization"`, abbr: `"i12iz4n"` | `true` |
| word: `"apple"`, abbr: `"a2e"` | `false` |
| word: `"hi"`, abbr: `"2i"` | `true` |
| word: `"a"`, abbr: `"01"` | `false` |
| word: `""`, abbr: `""` | `true` |
| word: `"hello"`, abbr: `"hello"` | `true` |

### Test Case Descriptions

1. **Basic valid abbreviation** - Classic example with multiple number segments
2. **Invalid abbreviation** - Letters don't align correctly ("a2e" would skip to position 3, but word[3] is 'l', not 'e')
3. **Number at start** - Abbreviation can start with a number
4. **Leading zero** - Numbers with leading zeros are invalid
5. **Empty strings** - Both empty should match (edge case)
6. **Exact match** - No abbreviation needed, letter-for-letter match
