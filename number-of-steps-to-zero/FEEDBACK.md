# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-25 19:35 PST] - Documentation Was Essential

**What I was trying to do:** Write a complete XanoScript run job and function from scratch without prior knowledge of XanoScript syntax.

**What the issue was:** I had zero knowledge of XanoScript syntax. My training data doesn't include XanoScript, so any syntax I would have guessed would have been wrong.

**Why it was an issue:** Without calling `xanoscript_docs` first, I would have written completely invalid code using JavaScript/TypeScript syntax patterns that don't exist in XanoScript.

**Potential solution (if known):** The prompt instructions were correct — I MUST call `xanoscript_docs` before writing ANY code. This workflow works well.

---

## [2025-02-25 19:35 PST] - No Validation Errors

**What I was trying to do:** Validate my XanoScript code using the MCP.

**What the issue was:** None — the code passed validation on the first attempt.

**Why it was an issue:** N/A — this is actually good feedback. The documentation was clear enough that I could write correct code immediately.

**Potential solution (if known):** The `quick_reference` mode for documentation is excellent. It gave me exactly what I needed without overwhelming me with details. The specific examples for function declarations, run.job structure, while loops, and variable updates were particularly helpful.

---

## [2025-02-25 19:35 PST] - Filter Precedence Reminder Was Critical

**What I was trying to do:** Write the condition `($current % 2) == 0` to check if a number is even.

**What the issue was:** I remembered from the syntax documentation that filters have high precedence and can cause parsing issues. I made sure to wrap expressions in parentheses.

**Why it was an issue:** Without the documentation's warning about parentheses and filter precedence, I might have written `$current|some_filter == 0` which would have failed.

**Potential solution (if known):** The documentation explicitly calling out `($arr|count) == 0` as the correct pattern was very helpful. Keep this warning prominent in the syntax docs.

---

## [2025-02-25 19:35 PST] - Variable Update Syntax

**What I was trying to do:** Update the step counter and current value inside the while loop.

**What the issue was:** I wasn't sure if XanoScript uses `var.update`, `$var += 1`, or some other pattern for updating variables.

**Why it was an issue:** Different languages handle variable mutation differently.

**Potential solution (if known):** The documentation showed `var.update $counter { value = $counter + 1 }` clearly. This worked perfectly. Having this example in the quickstart was essential.
