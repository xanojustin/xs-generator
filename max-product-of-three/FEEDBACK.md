# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 21:05 PST] - run.job Syntax Confusion

**What I was trying to do:** Create a run.xs file that runs multiple test cases for the max-product-of-three exercise.

**What the issue was:** I initially wrote the run.job syntax incorrectly as:
```xs
run.job {
  description = "..."
}

stack {
  // test cases here
}

response = $summary
```

This resulted in the error: `[Line 1, Column 9] Expecting: ... but found: '{'`

**Why it was an issue:** The documentation in the MCP only showed a very minimal example:
```xs
run.job {
  description = "Execute a function once"
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

But this syntax doesn't actually work. Looking at existing code in the repo, the correct syntax is:
```xs
run.job "Job Name" {
  main = {
    name: "function_name"
    input: { ... }
  }
}
```

The key differences:
1. The job name must be a quoted string after `run.job`
2. There's no separate `stack` block in run.xs - it just defines the main function to call

**Potential solution (if known):** The MCP docs for `run` topic should show the correct syntax with the job name as a required string parameter. The current docs show an invalid syntax.

---

## [2025-02-27 21:05 PST] - sort Filter Syntax Confusion

**What I was trying to do:** Sort an array of integers in ascending order.

**What the issue was:** Based on the documentation showing `[{n:"z"},{n:"a"}]|sort:n:text:false`, I tried:
```xs
var $sorted { value = $input.nums|sort:value:int:false }
```

This resulted in: `[Line 8, Column 44] ... but found: 'value'`

**Why it was an issue:** For sorting a simple array of primitives (integers), the correct syntax is just `|sort` with no parameters. The parameterized version is only for sorting arrays of objects by a specific property.

**Potential solution (if known):** The documentation should clarify:
- `|sort` - sorts a simple array of primitives
- `|sort:property:type:ascending` - sorts an array of objects by a property

---

## [2025-02-27 21:05 PST] - Array Element Access (get vs index)

**What I was trying to do:** Access array elements by index after sorting.

**What the issue was:** I used `$sorted|get:0` based on general intuition, but the correct filter is `$sorted|index:0`.

**Why it was an issue:** The documentation shows:
- `|get:N` returns a single element by index
- `|slice:offset:length` returns a sub-array

But when I tried using `|get:`, it didn't work. Looking at existing code in the repo, I found they use `|index:` instead.

**Potential solution (if known):** The documentation seems to have a mismatch. Either `|get` should work (and there's a bug), or the documentation should say `|index` instead of `|get`.

---

## [2025-02-27 21:05 PST] - Multi-Test Run Job Pattern Not Obvious

**What I was trying to do:** Create a run job that runs multiple test cases and logs results.

**What the issue was:** The run.job structure only allows calling a single main function. To run multiple tests, I had to create a separate `run_tests` function that then calls the actual solution function multiple times.

**Why it was an issue:** This wasn't obvious from the documentation. I had to look at existing examples (like integer-to-english) to understand the pattern:
1. run.xs calls a "run_tests" function
2. run_tests.xs (in function folder) calls the actual solution function multiple times with different inputs

**Potential solution (if known):** The documentation should include an example showing how to run multiple test cases from a run job, or explain the common pattern of having a test runner function.

---

## [2025-02-27 21:05 PST] - Missing json_encode in debug.log

**What I was trying to do:** Log the result of a function call which returns an object.

**What the issue was:** I initially wrote: `debug.log { value = "Test 1: " ~ ($result1|json_encode) }`

But looking at existing code, they don't use json_encode in debug.log - they just concatenate directly: `debug.log { value = "Test 1: " ~ $result1 }`

**Why it was an issue:** It's unclear when json_encode is needed vs when implicit conversion happens.

**Potential solution (if known):** Documentation should clarify type coercion rules for string concatenation with the `~` operator.
