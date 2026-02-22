# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-21 16:05 PST - run.job syntax confusion

**What I was trying to do:** Create a run job that calls a function with test inputs and logs results for multiple test cases.

**What the issue was:** I incorrectly assumed `run.job` would have the same structure as `task` or `function` constructs (with `description`, `stack`, and `response` blocks). When I wrote the run job with those elements, validation failed with errors like:
- `The argument 'description' is not valid in this context`
- `The argument 'stack' is not valid in this context`

**Why it was an issue:** The documentation I retrieved (`xanoscript_docs` with topic `tasks`) showed `task` syntax which has `description`, `stack`, and `schedule`, but there's no equivalent documentation for `run.job` syntax. I had to look at an existing implementation in the repo to understand that `run.job` uses a completely different structure with just a `main` field pointing to the function to call.

**Potential solution:** 
- Add documentation for `run.job` syntax to the `xanoscript_docs` tool
- Include examples showing the difference between `run.job` (simple function caller) vs `task` (scheduled job with stack)
- The `run` topic in documentation could cover run jobs and services

---

## 2025-02-21 16:03 PST - Limited run.job functionality

**What I was trying to do:** Run multiple test cases in a single run job and log the results of each.

**What the issue was:** The `run.job` construct appears to only support calling a single function with a single set of inputs via the `main` field. I couldn't find a way to:
- Run multiple test cases in sequence
- Use `debug.log` to output intermediate results
- Store and return multiple results

**Why it was an issue:** For a coding exercise generator, being able to test multiple inputs and show expected vs actual outputs would be valuable. I had to simplify the run job to just call one test case instead of the comprehensive test suite I originally wanted.

**Potential solution:**
- Clarify if `run.job` is intentionally simple (just a function entry point) or if it should support stack operations
- If intentionally simple, document this design decision and suggest using `task` for more complex orchestration
- Consider adding a `workflow_test` construct specifically for testing functions with multiple inputs

---

## 2025-02-21 16:00 PST - Finding existing examples

**What I was trying to do:** Understand the correct structure for run jobs.

**What the issue was:** The `xanoscript_docs` tool returned comprehensive documentation for functions, tasks, and other constructs, but I couldn't find specific documentation for `run.job`. I had to manually inspect an existing file (`~/xs/fizzbuzz/run.xs`) to understand the syntax.

**Why it was an issue:** Without documentation or examples, I was guessing at the syntax based on similar constructs, which led to the validation failures.

**Potential solution:**
- Add `run.job` documentation to the `tasks` or `run` topic
- Include a quick reference card showing all top-level constructs and their required/allowed fields
- Consider adding an `examples` topic to `xanoscript_docs` that shows minimal working examples of each construct type
