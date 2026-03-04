# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-03-03 16:35 PST] - Filter Expression Parentheses Requirement

**What I was trying to do:** Compare the result of a filter operation to a value (e.g., check if array count equals 0)

**What the issue was:** The validator rejected `$input.words|count == 0` with error "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** This is a common pattern in other languages where filters/pipes naturally bind tighter than comparisons. Having to wrap `($input.words|count)` in parentheses is non-obvious and the error message doesn't clearly explain the syntax requirement.

**Potential solution:** The error message could be more helpful by showing the correct syntax: "Wrap filter expressions in parentheses when comparing: `($input.words|count) == 0`"

---

## [2025-03-03 16:36 PST] - Sequential conditionals need separate blocks

**What I was trying to do:** Write multiple independent `if` statements one after another

**What the issue was:** The parser rejected sequential `if` statements with "Expecting: one of these possible Token sequences, but found: 'if'"

**Why it was an issue:** The documentation shows `conditional { if (...) {} elseif (...) {} else {} }` but doesn't clearly explain that each standalone `if` needs its own `conditional` block. I had:
```xs
conditional {
  if (...) { ... }
  if (...) { ... }  // This was rejected
}
```

**Potential solution:** The docs could have a note like: "Each independent `if` statement requires its own `conditional` block. Use `elseif` for mutually exclusive conditions within the same block."

---

## [2025-03-03 16:37 PST] - Response placement confusion

**What I was trying to do:** Set the function response based on computed values

**What the issue was:** I placed `response = ...` inside the `stack` block which is invalid. The function structure wasn't clear from the documentation examples.

**Why it was an issue:** The docs show:
```xs
function "name" {
  input { }
  stack { }
  response = $var
}
```

But I assumed `response` could be set dynamically inside `stack` like a return statement. The distinction between `return { value = ... }` for early exit vs `response = ...` for final output wasn't immediately obvious.

**Potential solution:** Add a clear note: "The `response` statement must be at the function level, outside the `stack` block. Use `return { value = ... }` for early exits inside conditionals."

---

## [2025-03-03 16:38 PST] - Array indexing with $variable

**What I was trying to do:** Access array elements using a variable index like `$input.words[$i]`

**What the issue was:** Unclear if this syntax is supported or if there's a different way to access array elements by variable index.

**Why it was an issue:** The documentation doesn't clearly explain array element access syntax. I used `$input.words[$i]` which seemed to work in validation, but I wasn't sure if it's the correct pattern.

**Potential solution:** Add array indexing to the essentials documentation with examples like `$array[$index]`.

---

## [2025-03-03 16:39 PST] - String character access

**What I was trying to do:** Access individual characters in a string by index

**What the issue was:** I initially tried `$word[$j]` assuming string indexing like arrays, but then switched to `$word|substr:$j:($j + 1)` to extract a single character.

**Why it was an issue:** It's unclear what the idiomatic way to access string characters is. The `substr` filter works but feels verbose for single character access.

**Potential solution:** Document string indexing if it exists, or recommend the `substr` approach for character extraction.

---
