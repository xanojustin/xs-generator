# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-20 12:32 PST] - Issue 1: run.job syntax confusion

**What I was trying to do:** Create a run.job that calls a function with test inputs and logs results

**What the issue was:** I incorrectly assumed run.job was like a function with `stack` and `response` blocks. The error messages were confusing because they said `description`, `stack`, and `response` were not valid in this context.

**Why it was an issue:** The quick_reference for `run` only showed:
```xs
run.job "Job Name" {
  main = { ... }
}
```

But I thought based on the exercise instructions that run.job should have its own logic. The full documentation later clarified that run.job is a configuration object that points to a function, not a function itself.

**Potential solution:** Make the quick_reference more explicit that run.job uses `main = { name: "...", input: {} }` syntax and cannot have `stack` or `response`. Add a prominent note like "run.job is NOT a function - it cannot contain stack logic."

---

## [2025-02-20 12:35 PST] - Issue 2: Filter expressions in conditionals need parentheses

**What I was trying to do:** Check if array count equals zero in a conditional

**What the issue was:** Code `$input.numbers|count == 0` failed validation with error: "An expression should be wrapped in parentheses when combining filters and tests"

**Why it was an issue:** The syntax rule is not intuitive - I need to write `($input.numbers|count) == 0` instead. The error message helped but the rule itself feels inconsistent since other operations don't require this.

**Potential solution:** The quickstart docs mention this briefly in string concatenation section but it should be more prominent. Add a specific section about "Filter expressions in comparisons" with examples like:
```xs
// ❌ Wrong
if ($arr|count == 5)

// ✅ Correct  
if (($arr|count) == 5)
```

---

## [2025-02-20 12:40 PST] - Issue 3: How to run multiple test cases from a run.job

**What I was trying to do:** Run multiple test cases from a single run.job as instructed

**What the issue was:** run.job can only call ONE function with ONE set of inputs via `main = { name: "...", input: {} }`. There's no way to call multiple functions or run multiple tests within a run.job.

**Why it was an issue:** The exercise instructions say "The run job is the entry point; the function contains the solution logic" and to demonstrate calling with test inputs. But run.job cannot do this directly - it needs an intermediate function to act as a test harness.

**Potential solution:** 
1. Either clarify in docs that run.job is just a pointer and you need a wrapper function for multiple tests
2. Or allow run.job to have a `stack` block that can call multiple functions (breaking change)
3. Or add a `tests` property to run.job specifically for testing scenarios

The pattern I ended up using (wrapper test function) works but isn't documented as the recommended approach.

---

## [2025-02-20 12:45 PST] - Issue 4: Lack of array manipulation examples

**What I was trying to do:** Build an array element by element in a loop (to initialize result array with 1s)

**What the issue was:** Couldn't find clear documentation on how to:
1. Create an empty array
2. Append to an array in a loop
3. Update a specific index in an array

**Why it was an issue:** The algorithm requires building a result array of the same size as input. I tried `var $result { value = [] }` and then `$result ~ [1]` to append, but this creates many intermediate arrays.

**Potential solution:** Add more array manipulation examples to the quickstart or syntax docs, specifically:
```xs
// Initialize empty array
var $arr { value = [] }

// Append to array
var $arr { value = $arr ~ [new_item] }

// Update index (requires slice and rebuild)
var $new_arr { value = ($arr|slice:0:index) ~ [new_val] ~ ($arr|slice:(index+1):(length-index-1)) }
```

The slice approach for updating a specific index feels verbose compared to other languages.

---

## General Feedback

**What's good:**
- The MCP validation tool is very helpful with specific line/column errors
- The quick_reference format is concise and useful
- Error messages often include helpful suggestions

**What could improve:**
1. More complete examples showing file structures (run.job + function together)
2. Clearer distinction between code objects (function, run.job) and their capabilities
3. Array manipulation patterns - this is a common need for algorithm exercises
4. Maybe a "common mistakes" section based on what developers from other languages get wrong
