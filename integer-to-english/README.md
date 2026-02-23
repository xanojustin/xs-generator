# Integer to English

## Problem

Convert a non-negative integer to its English words representation.

Given an integer `num`, return its representation in English words as a string.

### Examples
- Input: `123` → Output: `"One Hundred Twenty Three"`
- Input: `12345` → Output: `"Twelve Thousand Three Hundred Forty Five"`
- Input: `1234567` → Output: `"One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven"`

### Constraints
- `0 <= num <= 2,147,483,647` (max 32-bit signed integer)

---

## Structure

- **Run Job (`run.xs`):** Calls the solution function with multiple test inputs and logs results
- **Function (`function/integer_to_english.xs`):** Contains the solution logic with a helper function for converting chunks

---

## Function Signature

### Main Function: `integer_to_english`

- **Input:**
  - `num` (int): A non-negative integer to convert (0 to 2,147,483,647)
  
- **Output:** (text)
  - The English words representation of the input number
  - Returns `"Zero"` for input 0

### Helper Function: `convert_chunk`

- **Input:**
  - `num` (int): A number from 1-999 to convert
  - `ones` (text[]): Array of ones place words ("", "One", "Two", ..., "Nineteen")
  - `tens` (text[]): Array of tens place words ("", "", "Twenty", ..., "Ninety")
  
- **Output:** (text)
  - The English words representation of the chunk (1-999)

---

## Algorithm Explanation

The solution breaks down the number into groups of three digits (thousands, millions, billions) and processes each group:

1. **Handle Zero:** Return "Zero" immediately for input 0
2. **Process Large Groups:** Extract billions, millions, and thousands
3. **Convert Each Chunk:** Use a helper function to convert numbers 1-999:
   - Handle hundreds place (if >= 100)
   - Handle tens and ones (20-99 uses tens array, 1-19 uses ones array directly)
4. **Combine Results:** Join chunks with appropriate scale words (Billion, Million, Thousand)

---

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| 0 | "Zero" |
| 5 | "Five" |
| 15 | "Fifteen" |
| 30 | "Thirty" |
| 42 | "Forty Two" |
| 100 | "One Hundred" |
| 123 | "One Hundred Twenty Three" |
| 1000 | "One Thousand" |
| 12345 | "Twelve Thousand Three Hundred Forty Five" |
| 1000000 | "One Million" |
| 1234567 | "One Million Two Hundred Thirty Four Thousand Five Hundred Sixty Seven" |

### Test Case Categories

- **Basic/Happy Path:** 5, 15, 30, 42, 123
- **Edge Cases:** 0 (zero), 100 (exact hundred), 1000 (exact thousand), 1000000 (exact million)
- **Boundary/Interesting:** 12345 (multiple groups), 1234567 (all groups populated)

---

## XanoScript Features Used

- **Variable declaration** with `var`
- **Conditional blocks** with `if`, `elseif`
- **Function calls** using `function.run`
- **Arrays** for word lookups
- **Array filters** (`get`, `count`)
- **Type filters** (`to_int`)
- **Math operations** (`/`, `%`, `+`)
- **String concatenation** with `~` operator
- **Multiple functions** in a single file
- **Early return** from function via `response = ...` followed by `return`
