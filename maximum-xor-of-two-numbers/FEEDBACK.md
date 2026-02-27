# FEEDBACK.md - Xano MCP/XanoScript Feedback

## [2025-02-27 12:00 PST] - Missing Bitwise Operators

**What I was trying to do:** Implement a trie-based maximum XOR algorithm that requires bit manipulation (right shift `>>` and bitwise AND `&`).

**What the issue was:** XanoScript doesn't support bitwise operators (`>>`, `<<`, `&`, `|`, `^`, `~`). The validator gave a cryptic error about expecting various tokens but finding `>`.

**Why it was an issue:** Many classic algorithms (especially those involving binary representations, tries, or bit manipulation) require bitwise operations. Without them, I had to completely rewrite the algorithm using mathematical operations:
- `num >> n` became `num / (2^n)`
- `num & 1` became `num % 2`
- `num << n` became `num * (2^n)`

**Potential solution (if known):** 
- Add bitwise operators to XanoScript syntax
- OR provide clear documentation about which operators are NOT supported
- OR provide math filters for bitwise operations (e.g., `bit_shift_right`, `bit_and`, etc.)

---

## [2025-02-27 12:00 PST] - run.job Syntax Documentation Gaps

**What I was trying to do:** Create a run.xs file that defines a run job and a test function.

**What the issue was:** The quick reference documentation showed:
```xs
run.job {
  main = ...
}
```

But the actual syntax requires a name string:
```xs
run.job "Job Name" {
  main = ...
}
```

Also, `description` is not a valid property in run.job (unlike functions which do support it).

**Why it was an issue:** The initial validation failed with confusing errors. I had to dig into the full documentation to find the correct syntax.

**Potential solution (if known):** 
- Update the quick reference to show the correct syntax with the job name
- Make the error message more helpful - suggest adding a name string

---

## [2025-02-27 12:00 PST] - Functions Cannot Be Defined in run.xs

**What I was trying to do:** Define a test function inside run.xs alongside the run.job.

**What the issue was:** The validator rejected the file with "Redundant input, expecting EOF but found: function". Functions must be in separate files in a `function/` directory.

**Why it was an issue:** I assumed run.xs could contain both the run.job definition and supporting functions. This wasn't clear from the quick reference.

**Potential solution (if known):**
- Clarify in the run.job documentation that functions must be in separate files
- Improve error message to suggest moving function to a separate file

---

## [2025-02-27 12:00 PST] - for Loop each Syntax Confusion

**What I was trying to do:** Use a `for` loop to iterate N times without needing an index variable.

**What the issue was:** I wrote:
```xs
for ($bit_pos) {
  each {
    var.update $divisor { value = $divisor * 2 }
  }
}
```

But the validator required:
```xs
for ($bit_pos) {
  each as $j {
    var.update $divisor { value = $divisor * 2 }
  }
}
```

**Why it was an issue:** The error message was confusing - "Expecting 'as' but found '{'". It wasn't immediately clear that `each` in a `for` loop requires a variable name even if you don't use it.

**Potential solution (if known):**
- Allow `each {` without `as $var` when the index isn't needed
- OR improve documentation to show that `each as $var` is required

---

## [2025-02-27 12:00 PST] - pow Filter Not Available for Integer Exponents

**What I was trying to do:** Calculate powers of 2 (2^n) for bit position calculations.

**What the issue was:** The syntax/functions documentation lists `pow` as a filter (`2|pow:3`), but it's not clear if it works with variables. I ended up using a nested for loop to multiply, which is verbose.

**Why it was an issue:** Without a pow function that works with variables, calculating powers is cumbersome:
```xs
var $divisor { value = 1 }
for ($bit_pos) {
  each as $j {
    var.update $divisor { value = $divisor * 2 }
  }
}
```

**Potential solution (if known):**
- Clarify in docs if `pow` works with variables
- OR provide a dedicated `bit_shift` filter for powers of 2

---

## [2025-02-27 12:00 PST] - mcporter Call Syntax Quoting Issues

**What I was trying to do:** Validate multiple files at once using the file_paths parameter.

**What the issue was:** The shell command quoting for arrays is tricky:
```bash
# This failed with zsh quoting errors:
mcporter call xano.validate_xanoscript file_paths='["path1", "path2"]'
```

**Why it was an issue:** Had to validate files one at a time instead of batch validation.

**Potential solution (if known):**
- Document the correct shell escaping for complex parameters
- OR provide a simpler interface for batch validation (e.g., directory parameter)

---

## Summary

Overall the Xano MCP validation tool is helpful and catches syntax errors early. The main friction points were:

1. **Missing operators** - Bitwise operations are common in algorithms but not supported
2. **Documentation gaps** - Some syntax details only appear in full docs, not quick reference
3. **Error messages** - Could be more actionable, suggesting the fix
4. **File structure rules** - Not immediately obvious that functions must be separate

The tool worked well once I understood these constraints, and the iterative validation workflow was effective.
