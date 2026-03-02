# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2026-03-02 10:35 PST] - Comment placement restrictions

**What I was trying to do:** Write a XanoScript function with comments explaining the algorithm at the top of the file.

**What the issue was:** The validator rejected comments placed before the `function` block. The error message was:
```
[Line 3, Column 1] Expecting --> function <-- but found --> '
' <--
```

**Why it was an issue:** I assumed standard comment syntax (`//`) would work anywhere in the file, like in most programming languages. The error message was confusing because it mentioned finding a newline character rather than clearly stating "comments must be inside function blocks".

**Potential solution:** 
- Update documentation to explicitly state that comments must be inside blocks
- Provide a clearer error message like "Comments must be placed inside function/stack blocks, not before the function declaration"
- Or allow comments at file level if that's technically feasible

---

## [2026-03-02 10:38 PST] - Filter expression parentheses requirement

**What I was trying to do:** Compare the lengths of two strings using filters in a conditional expression.

**What the issue was:** The validator rejected:
```
if ($input.s1|strlen > $input.s2|strlen) {
```

With error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The error message says "an expression" (singular) should be wrapped, but both filter expressions need wrapping. The phrasing is ambiguous - I wasn't sure if I needed:
- `($input.s1|strlen > $input.s2|strlen)` (whole expression)
- `($input.s1|strlen) > ($input.s2|strlen)` (each filter)
- Something else

Trial and error revealed both filter expressions need individual wrapping.

**Potential solution:**
- Change error to: "Filter expressions must be wrapped in parentheses when used in comparisons. Example: `if (($var|filter) > ($other|filter))`"
- Or allow unwrapped filters and handle it internally

---

## [2026-03-02 10:30 PST] - mcporter call syntax inconsistency

**What I was trying to do:** Call the `xanoscript_docs` tool with a topic parameter.

**What the issue was:** The mcporter help shows multiple argument styles but I couldn't get `--args` JSON format to work. The command:
```
mcporter call xano xanoscript_docs --input '{"topic": "functions"}'
```
Resulted in: "Unknown topic '--input'"

**Why it was an issue:** The help text shows `--args <json>` as an option, but using `--input` (which is natural for many APIs) failed silently by passing the flag name as the topic parameter.

**Potential solution:**
- The error was actually helpful once I realized what happened - it showed available topics and "--input" was being parsed as a topic name
- Maybe reject arguments that start with `--` as invalid topic names
- Or make the error message clearer: "Unknown topic '--input'. Did you mean to use --args?"

---

## [2026-03-02 10:42 PST] - Documentation discoverability

**What I was trying to do:** Find the correct syntax for run.job to call a function.

**What the issue was:** The `xanoscript_docs` topic list is long and not organized by use case. I had to guess that `run` would contain job documentation.

**Why it was an issue:** As a new XanoScript developer, I don't know the terminology. I was looking for "jobs", "run jobs", "scheduled tasks" - it's unclear that `run` is the right topic.

**Potential solution:**
- Add tags or categories to topics (e.g., `run: [jobs, scheduled-tasks, entry-point]`)
- Provide a search functionality in the docs tool
- Add a "Getting Started" or "Common Patterns" topic that links to frequently used constructs

---

## Overall Experience

The validation tool is **very helpful** - it catches errors quickly and provides actionable suggestions. The main pain points were:
1. Understanding the specific syntax rules (parentheses around filters, comment placement)
2. Getting the initial structure right without examples

The mcporter integration works well once you understand the key=value syntax. The documentation is comprehensive once you find the right topic.
