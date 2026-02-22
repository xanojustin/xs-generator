# FEEDBACK.md - Xano MCP/XanoScript Feedback

## 2025-02-22 11:35 PST - MCP Server Naming Issue

**What I was trying to do:** Call the validate_xanoscript tool on the Xano MCP

**What the issue was:** The mcporter call syntax was inconsistent. Using `mcporter call xano.validate_xanoscript` with `directory=.` or relative paths failed with "Unknown MCP server 'xano'." error. 

**Why it was an issue:** The error message was misleading - it suggested the server didn't exist, when actually the issue was with the path format or how the arguments were being parsed.

**What worked:** Using the full function syntax with quoted server name and absolute path:
```
mcporter call "xano.validate_xanoscript" directory="/Users/justinalbrecht/xs/longest-repeating-character-replacement"
```

**Potential solution:** The MCP or mcporter could provide better error messages distinguishing between "server not found" vs "parameter parsing error" vs "file not found".

---

## 2025-02-22 11:35 PST - Documentation Gap: for() loop syntax

**What I was trying to do:** Use a for loop to iterate through the string by index

**What the issue was:** The documentation shows `for (10)` for a count-based loop but doesn't clearly explain how to get the current iteration index with `each as $i`. I had to infer this from the foreach example.

**Why it was an issue:** It wasn't immediately clear that `for (count)` + `each as $variable` would give me the index from 0 to count-1. I had to make an assumption and hope it worked.

**Potential solution:** Add a clearer example in the quickstart or functions docs showing:
```xs
for (10) {
  each as $i {
    // $i is 0, 1, 2, ... 9
  }
}
```

---

## 2025-02-22 11:35 PST - Documentation Gap: while loop variable updates

**What I was trying to do:** Update variables inside a while loop condition

**What the issue was:** I needed to recalculate `$window_size` inside the while loop after updating `$left`. It wasn't clear if the while condition is re-evaluated after each iteration with the updated variables.

**Why it was an issue:** I had to assume XanoScript re-evaluates the while condition on each iteration with current variable values (which is standard behavior, but worth confirming).

**Potential solution:** Add a note in the functions documentation about while loop behavior and variable scope updates.

---

## 2025-02-22 11:35 PST - Positive Feedback: Clear Type System

**What went well:** The type system documentation was very clear about using `text` instead of `string`, `int` instead of `integer`, etc. The quickstart guide's "Common Mistakes" section was especially helpful.

**What worked well:** 
- The quick reference tables comparing wrong vs correct syntax
- The explicit note about `elseif` vs `else if`
- The warning about reserved variable names

---
