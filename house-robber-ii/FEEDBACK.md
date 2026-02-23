# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-02-23 13:35 PST] - Documentation Access

**What I was trying to do:** Access XanoScript documentation via the MCP server to understand syntax before writing code.

**What the issue was:** The initial command `npx -y @xano/developer-mcp xanoscript_docs` was taking a long time and appeared to hang. I had to use `mcporter` instead, which worked well.

**Why it was an issue:** Direct npx execution wasn't working reliably, but mcporter was already configured and provided fast access to the MCP tools.

**Potential solution:** The skill/cron job could be updated to recommend `mcporter call xano.xanoscript_docs` as the primary method for accessing documentation.

---

## [2026-02-23 13:35 PST] - Validation Success

**What I was trying to do:** Validate the XanoScript files I created.

**What the issue was:** No issues - both files passed validation on the first try!

**Why it was a positive experience:** The documentation was clear enough that I was able to write valid XanoScript without any syntax errors. Key things that helped:
1. Clear examples in the quickstart guide showing proper structure
2. The distinction between `run.job` and `run.service` was well documented
3. The `function` structure with `input`, `stack`, and `response` blocks was intuitive
4. The common mistakes section helped me avoid errors like using `else if` instead of `elseif`

**Potential improvement:** While the documentation is comprehensive, having more algorithm-focused examples (like dynamic programming patterns) would be helpful for coding exercises like this one.

---

## [2026-02-23 13:35 PST] - Ternary Operator Discovery

**What I was trying to do:** Implement a max comparison in the algorithm.

**What the issue was:** I wasn't sure if XanoScript had a ternary operator or if I needed to use conditionals.

**Why it was an issue:** The syntax documentation doesn't explicitly mention the ternary operator format (`condition ? value_if_true : value_if_false`).

**Potential solution:** Add a note in the syntax documentation about ternary operator support. I discovered it works through experimentation.

---

## [2026-02-23 13:35 PST] - Array Slice and First Filter Usage

**What I was trying to do:** Access individual elements from the input array within a while loop.

**What the issue was:** XanoScript doesn't appear to have direct array indexing like `houses[i]`. I had to use `slice:$i:1|first` to get a single element.

**Why it was an issue:** This pattern is verbose and not immediately obvious from the documentation.

**Potential solution:** Document common array access patterns more explicitly. A direct indexing syntax or a dedicated `nth` filter would make code more readable:
```xs
// Current approach (verbose)
$input.houses|slice:$i:1|first

// Could be cleaner with
$input.houses|nth:$i
```

---

## [2026-02-23 13:35 PST] - Filter Parentheses Confusion

**What I was trying to do:** Use filters in expressions with operators.

**What the issue was:** I initially wasn't sure if I needed parentheses around filter expressions when using them with operators.

**Why it was an issue:** The quickstart documentation mentions this, but it's easy to miss. I found myself wondering if `$input.houses|count == 0` needed parentheses.

**Potential solution:** The documentation is actually good here - it explicitly mentions this in the Common Mistakes section. I just needed to read more carefully!
