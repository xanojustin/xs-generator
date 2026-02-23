# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-02-23 01:05 PST - Missing math.random documentation

**What I was trying to do:** Implement a Fisher-Yates shuffle algorithm that requires generating random indices

**What the issue was:** I attempted to use `math.random(0, $i)` to generate a random number, but the validator returned:
```
[Line 13, Column 26] Expecting: Expected an expression but found: 'math'
```

This indicates that either:
1. `math.random` doesn't exist in XanoScript
2. The syntax is different from what I expected
3. There's no built-in random number generation function

**Why it was an issue:** Random number generation is a fundamental operation for many algorithms (shuffling, simulations, games, etc.). Not having access to this or not knowing the correct syntax made implementation difficult.

**Workaround used:** I used a timestamp-based pseudo-random approach:
```xs
var $timestamp { value = now|format_timestamp:"U":"UTC"|to_int }
var $j { value = ($timestamp % ($i + 1)) }
```

This is not ideal because:
- It's not truly random (based on current timestamp)
- In a tight loop, multiple iterations might get the same timestamp
- It's not the intended Fisher-Yates algorithm behavior

**Potential solution (if known):** 
1. Add `math.random(min, max)` or similar function to XanoScript
2. Document the correct way to generate random numbers in the syntax docs
3. If there's already a way, make it more discoverable in the quickstart/syntax documentation

## 2026-02-23 01:07 PST - Documentation gaps for common programming tasks

**What I was trying to do:** Find documentation on how to perform common programming operations like random number generation

**What the issue was:** The `syntax` documentation covers filters extensively but doesn't clearly document:
1. How to generate random numbers
2. Available `math.*` functions (if any exist)
3. Utility functions beyond filters

**Why it was an issue:** When writing algorithms, I need to know what building blocks are available. Without clear documentation of math/utility functions, I have to guess and check via the validator.

**Potential solution (if known):** 
1. Add a "Math Functions" or "Utility Functions" section to the syntax docs
2. Include a complete list of available functions beyond just filters
3. Add examples for common algorithmic patterns

---
