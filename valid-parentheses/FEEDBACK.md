# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-19 00:33 PST] - Incorrect conditional block syntax assumption

**What I was trying to do:** Write a valid-parentheses function that uses conditional logic (if/elseif/else) to check bracket matching

**What the issue was:** I incorrectly assumed that `conditional` blocks required `each` wrappers around their contents, similar to how `while` loops work. I wrote:
```xs
conditional {
  if (condition) {
    each {
      // statements
    }
  }
}
```

When the correct syntax is:
```xs
conditional {
  if (condition) {
    // statements directly, no each wrapper
  }
}
```

**Why it was an issue:** This caused a parse error: "Expecting --> } <-- but found --> 'each' <--". The validation error was clear about the location but the suggestion about using "text" instead of "string" was unrelated and confusing.

**Potential solution (if known):** 
- The documentation clearly shows this in the quickstart examples, but I missed it. 
- Perhaps a more explicit note that `each` is ONLY for `while` loops, not for `conditional` blocks.
- The error suggestion was misleading - it mentioned type declarations when the issue was about block structure.

---

## [2026-02-19 00:33 PST] - String slicing uncertainty

**What I was trying to do:** Extract a single character from a string by index to iterate through the bracket string

**What the issue was:** I wasn't sure if the `slice` filter syntax was correct. I used: `($input.brackets|slice:$index:($index + 1))`

**Why it was an issue:** The syntax validation passed, but I had to guess based on the filter pattern I saw in the documentation. The `slice` filter isn't explicitly documented in the quick reference, so I inferred it from the general filter syntax pattern.

**Potential solution (if known):** 
- Include common string manipulation filters (slice, substring, char_at) in the quick reference
- Document the exact syntax for filter arguments (e.g., can they be expressions like `($index + 1)`?)

---

## [2026-02-19 00:33 PST] - Array/stack operations unclear

**What I was trying to do:** Implement a stack (push and pop operations) using arrays

**What the issue was:** I couldn't find documentation on how to:
1. Push to an array (I used `merge` which might not be the intended way)
2. Pop from an array (I used `slice:0:($stack_count - 1)` to get all but the last element)
3. Get the last element (I used the `last` filter which I assumed exists based on `first`)

**Why it was an issue:** Without clear array manipulation docs, I had to make assumptions about which filters exist and how to use them. The validation passed so my assumptions were correct, but this was lucky guessing rather than confident coding.

**Potential solution (if known):** 
- Document all available array filters: push, pop, shift, unshift, slice, last, etc.
- Provide examples of common data structure implementations (stack, queue) in the quickstart

---

## [2026-02-19 00:33 PST] - Boolean comparison syntax question

**What I was trying to do:** Check if a boolean variable equals `true` in a while loop condition

**What the issue was:** I wrote: `while ($index < $length && $is_valid == true)` 

I wasn't sure if:
- `$is_valid == true` is the correct syntax
- `$is_valid` alone would work (truthy check)
- `==` vs `=` for comparison

**Why it was an issue:** The validation passed, but I had to guess based on common programming language patterns. The documentation shows `==` for comparison but doesn't explicitly show boolean comparisons.

**Potential solution (if known):** 
- Add a boolean comparison example to the quickstart
- Clarify if truthy/falsy checks work (e.g., `while ($is_valid)` vs `while ($is_valid == true)`)

---
