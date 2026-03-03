# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-03-02 21:05 PST - While Loop Syntax Not Clear in Initial Docs

**What I was trying to do:** Write a while loop to iterate through array indices for cycle detection

**What the issue was:** Got error "Expecting --> each <-- but found --> '\n' <--" when trying to use a while loop. The initial documentation I retrieved didn't clearly show that while loops require an `each` block inside them.

**Why it was an issue:** The error message was cryptic and didn't explain *why* `each` was expected. I had to dig deeper into the essentials documentation to find the correct pattern.

**Potential solution:** The main docs should prominently feature the while loop syntax with `each` block, or the error message could be more descriptive like "while loops must contain an 'each' block for their body".

---

## 2026-03-02 21:07 PST - Filter Expression Parentheses Requirement

**What I was trying to do:** Compare the result of a filter operation: `$input.arr|count <= 1`

**What the issue was:** Got error "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The syntax requirement for parentheses around filter expressions when used in comparisons wasn't immediately obvious from the examples.

**Potential solution:** The quick reference section could have a clear example like: `if (($array|count) > 0)` instead of just `if ($array|count > 0)` to show the required parentheses.

---

## 2026-03-02 21:10 PST - Documentation Discovery

**What I was trying to do:** Find the correct XanoScript syntax for various constructs

**What the issue was:** Had to make multiple calls to `xanoscript_docs` with different topic parameters to piece together the full picture - one for general docs, one for essentials, one for run jobs.

**Why it was an issue:** It wasn't immediately clear which topics contained which information. I had to guess that "essentials" would have common patterns and "run" would have run job syntax.

**Potential solution:** A topic index or `xanoscript_docs` without parameters could return a structured index of what each topic covers, making it easier to find the right docs.

---

## 2026-03-02 21:12 PST - Array Index Access with Variables

**What I was trying to do:** Access array elements using a variable index: `$visited[$idx]`

**What the issue was:** Was unsure if this syntax was correct since some languages use different array access patterns.

**Why it was an issue:** The documentation examples mostly show fixed index access (e.g., `$arr[0]`) rather than dynamic index access with variables.

**Potential solution:** Include examples of dynamic array access in the essentials documentation to confirm this pattern works.

---

## General Observations

The `validate_xanoscript` tool is excellent for catching syntax errors! The error messages include line numbers and the problematic code snippet, which makes fixing issues much faster. The main friction points were:

1. **Syntax discovery** - Need to query multiple doc topics to get complete picture
2. **Error clarity** - Some errors could be more descriptive about *why* something is wrong
3. **Pattern examples** - More real-world examples in the main docs would reduce the need to search through multiple topics
