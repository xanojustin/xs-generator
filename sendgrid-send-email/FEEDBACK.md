# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-13 14:59 PST] - Documentation Discovery Experience

**What I was trying to do:**
Find XanoScript syntax documentation to write a run job for sending emails via SendGrid API.

**What the issue was:**
Initially, I didn't know what documentation topics were available through the MCP. The tool schema showed available topics, but I had to explore by calling the tool to understand what each topic contained.

**Why it was an issue:**
It took multiple calls to xanoscript_docs to gather all the necessary information:
1. First call for "run" topic - got run.job/run.service syntax
2. Second call for "quickstart" - got common patterns
3. Third call for "functions" - got function definition syntax
4. Fourth call for "syntax" - got expression/filter details

**Potential solution (if known):**
A single "complete_reference" topic or a topic index that lists all available sections with brief descriptions would be helpful. Alternatively, a `xanoscript_docs({topic: "index"})` call that returns all available topics with summaries would reduce the number of API calls needed.

---

## [2025-02-13 15:00 PST] - Variable Reassignment Clarity

**What I was trying to do:**
Update a variable conditionally within a conditional block (for the $success and $error_message variables).

**What the issue was:**
In my first attempt, I declared `var $success { value = false }` before the conditional block, then tried to update it inside conditional branches using `var $success { value = true }`. This creates a new variable scope rather than updating the existing one.

**Why it was an issue:**
The documentation mentions `var.update` for updating variables, but the examples mostly show simple cases. It wasn't immediately clear that re-declaring with `var` inside a conditional creates a new scope rather than updating the outer variable.

**Potential solution (if known):**
More explicit examples showing variable update patterns inside conditional blocks would help. Something like:
```xs
// Pattern for updating variables conditionally
var $result { value = "default" }
conditional {
  if ($condition) {
    var.update $result { value = "updated" }  // Use var.update, not var
  }
}
```

---

## [2025-02-13 15:01 PST] - Positive Feedback: Validation Tool

**What I was trying to do:**
Validate XanoScript syntax before committing files.

**What worked well:**
The `validate_xanoscript` tool worked flawlessly. It provided clear "No syntax errors found" messages when code was valid. I appreciated that it auto-detects the object type (run.job, function, etc.) from the code syntax.

**Why it was helpful:**
Catching syntax errors before deployment saves time and prevents broken code from being committed. The tool responded quickly and gave confidence that the code would work.

**Potential improvement:**
When validation passes, perhaps return a summary of what was detected (e.g., "Valid run.job configuration with 1 referenced function"). When validation fails, include line numbers and helpful error messages (though I didn't encounter any errors to test this).

---

## [2025-02-13 15:02 PST] - String Concatenation with Filters

**What I was trying to do:**
Build an error message that includes both a string and a status code converted to text.

**What the issue was:**
The documentation clearly states that when using filters in string concatenation, you must wrap the filtered expression in parentheses:
```xs
// Correct
var $message { value = ($status|to_text) ~ ": " ~ ($data|json_encode) }
```

However, this pattern is easy to forget and the error message when you get it wrong isn't always clear about the parentheses requirement.

**Why it was an issue:**
While the documentation covers this well in the "Common Mistakes" section, it's a subtle syntax requirement that differs from many other languages.

**Potential solution (if known):**
This is well documented, but perhaps a linting warning or more explicit error message when concatenating filtered expressions without parentheses would help developers catch this faster.

---

## Overall Assessment

The Xano MCP worked well for this task:

**Strengths:**
- Documentation is comprehensive and well-organized by topic
- Validation tool is fast and accurate
- The syntax is clean and intuitive once you learn the patterns
- Error handling with preconditions is elegant

**Areas for improvement:**
1. A documentation index or "getting started" guide that lists all available topics
2. More examples of complex variable update patterns
3. Perhaps a "best practices" topic for common patterns like API requests with error handling

The SendGrid email sending run job was completed successfully with all validations passing.
