# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2026-03-04 01:32 PST - First-time setup was smooth

**What I was trying to do:** Set up a complete XanoScript exercise with run.job and function

**What the issue was:** No issues - validation passed on first attempt

**Why it was an issue:** N/A - everything worked well

**Potential solution (if known):** N/A

---

## 2026-03-04 01:32 PST - Documentation was comprehensive

**What I was trying to do:** Learn XanoScript syntax for loops, conditionals, and variable operations

**What the issue was:** No issues - the xanoscript_docs MCP tool provided excellent documentation

**Why it was an issue:** N/A

**Potential solution (if known):** N/A

---

## 2026-03-04 01:32 PST - Absolute value pattern could be clearer

**What I was trying to do:** Compute absolute value of differences between array elements

**What the issue was:** XanoScript doesn't have a built-in `abs()` function. I had to use a conditional to check if the value is negative and negate it.

**Why it was an issue:** This creates verbose code for a common mathematical operation:
```xs
var $diff { value = $x - $y }
conditional {
  if ($diff < 0) {
    var $diff { value = 0 - $diff }
  }
}
```

**Potential solution (if known):** A built-in `abs()` filter or function would be helpful:
```xs
var $diff { value = ($x - $y)|abs }
```

---

## 2026-03-04 01:32 PST - Array access by index could be simplified

**What I was trying to do:** Access individual array elements by index (e.g., `arr[i]`)

**What the issue was:** XanoScript doesn't have direct array indexing. I had to use `slice:index:1|first` pattern which is verbose.

**Why it was an issue:** This creates verbose code:
```xs
var $val { value = ($input.arr|slice:$i:1|first) }
```

**Potential solution (if known):** An `at` or `get` filter for arrays would be helpful:
```xs
var $val { value = $input.arr|at:$i }
```

---

## 2026-03-04 01:32 PST - Variable re-declaration in conditionals

**What I was trying to do:** Update the absolute value variable within a conditional block

**What the issue was:** I had to re-declare the variable with `var $diff` inside the conditional block because `var.update` wasn't clearly documented for this pattern.

**Why it was an issue:** It's unclear if `var.update` works inside conditionals or if variable shadowing is the intended pattern.

**Potential solution (if known):** Clarify in documentation the recommended pattern for updating variables within conditional blocks.
