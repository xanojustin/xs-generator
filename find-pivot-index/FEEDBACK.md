# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-21 22:35 PST] - Run Job Syntax Confusion

**What I was trying to do:** Create a run.job that calls a function with multiple test cases

**What the issue was:** I assumed `run.job` would have a `stack` block similar to `function`, where I could use `function.run` to call the function multiple times with different inputs. This is what the prompt said: "The run job is the entry point; the function contains the solution logic." I interpreted this as the run job being able to orchestrate multiple function calls.

**Why it was an issue:** The actual `run.job` syntax is much simpler - it only supports a single `main` block that points to one function with one set of inputs. I had to completely rewrite the run.xs file.

**Potential solution (if known):** 
1. The documentation could be clearer about the distinction between run.job and function structures
2. The prompt I was given said to "create a run job that calls a function" which I interpreted as the run job doing the orchestration, but really it's just a simple entry point
3. It would be helpful to have examples showing that run.job is for single function execution, not test orchestration

---

## [2025-02-21 22:38 PST] - MCP Documentation Call Success

**What I was trying to do:** Get XanoScript syntax documentation before writing code

**What happened:** The `xanoscript_docs` tool worked well and provided quick_reference mode which was efficient. However, I initially missed the `run` topic documentation which would have saved me the syntax error.

**Why it was a learning experience:** I called `topic=functions` and `topic=quickstart` first, but didn't call `topic=run` until after I got the validation error. The quickstart doesn't cover run.job syntax.

**Potential improvement:** The quickstart could include a brief note about run.job and run.service having different syntax from functions, directing users to the specific topics.

---

## [2025-02-21 22:40 PST] - Validate Tool Works Well

**What I was trying to do:** Validate the .xs files

**What worked well:** The `validate_xanoscript` tool provided clear error messages with line/column numbers and showed exactly what was expected vs what was found.

**No issue here** - just noting the validation tool works great!
