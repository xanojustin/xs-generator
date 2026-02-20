# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 08:35 PST] - Conditional Block Syntax Unclear

**What I was trying to do:** Write a function with multiple edge case checks using separate `if` statements inside a `conditional` block.

**What the issue was:** I initially wrote:
```xs
conditional {
  if ($input.n <= 0) {
    return { value = [] }
  }
  if ($input.n == 1) {
    return { value = [["Q"]] }
  }
}
```

This produced the error: "Expecting: one of these possible Token sequences: [// comment], [description], [disabled], [if] but found: 'if'"

**Why it was an issue:** The error message was confusing because it said it expected `[if]` but found 'if'. This seems contradictory. I had to infer that within a `conditional` block, you cannot have multiple top-level `if` statements - you must use `elseif` for subsequent conditions.

**Potential solution (if known):** 
1. Improve the error message to explicitly say something like "Use 'elseif' instead of 'if' for additional conditions within a conditional block"
2. Add documentation about the conditional/elseif pattern to the quickstart guide

---

## [2025-02-20 08:30 PST] - Documentation Topics Return Same Content

**What I was trying to do:** Get specific documentation for topics like `quickstart`, `functions`, `syntax`, and `run` to understand XanoScript patterns.

**What the issue was:** Calling `xanoscript_docs` with different topics (`quickstart`, `functions`, `syntax`, `run`) all returned nearly identical content - the same overview/quick reference instead of topic-specific documentation.

**Why it was an issue:** I couldn't get detailed syntax information for:
- How to properly structure conditional blocks
- The difference between `if` inside vs outside `conditional`
- Return statement patterns
- Function.run syntax details

I had to rely on reading existing example files in the `~/xs/` directory to understand patterns, which is less efficient than having proper documentation.

**Potential solution (if known):** 
1. Fix the topic filtering in the MCP so different topics return different, specific content
2. Add a `cheatsheet` topic that actually returns a compact syntax reference
3. Include more code examples in the documentation for common patterns

---

## [2025-02-20 08:30 PST] - MCP Parameter Passing Syntax Unclear

**What I was trying to do:** Call the `validate_xanoscript` tool with a directory parameter.

**What the issue was:** It took several attempts to figure out the correct CLI syntax. Eventually `directory=/Users/justinalbrecht/xs/n-queens` worked.

**Why it was an issue:** The error messages weren't helpful in guiding toward the correct syntax. The help text shows JSON examples but the actual working syntax uses key=value format.

**Potential solution (if known):** 
1. Update the help/examples to show the actual working syntax for mcporter
2. Accept both JSON and key=value formats more consistently

---