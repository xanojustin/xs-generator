# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/calculate_handicap.xs`
**Result:** Fail on function file

**Errors found:**
```
✗ calculate_handicap.xs: Found 1 error(s):
1. [Line 5, Column 7] Expecting --> } <-- but found --> '{' <--
Code at line 5:
  { description = "PHRF rating of the boat (lower is faster)" }
```

**Issue:** I incorrectly tried to add `description` fields inside the input block using curly brace syntax. This is not valid XanoScript input syntax.

---

## Validation 2 - Removed invalid description blocks

**Files changed:** `function/calculate_handicap.xs`

**Validation errors being addressed:**
```
[Line 5, Column 7] Expecting --> } <-- but found --> '{' <--
{ description = "PHRF rating of the boat (lower is faster)" }
```

**Diff:**
```diff
   input {
-    int phrf_rating filters=min:-500|max:300
-      { description = "PHRF rating of the boat (lower is faster)" }
-    decimal course_distance filters=min:0
-      { description = "Course distance in nautical miles" }
-    int elapsed_time_seconds filters=min:0
-      { description = "Actual elapsed time in seconds" }
+    int phrf_rating filters=min:-500|max:300
+    decimal course_distance filters=min:0
+    int elapsed_time_seconds filters=min:0
   }
```

**Result:** Pass - both files now valid

**Learning:** Input field descriptions in XanoScript don't use `{ description = "..." }` blocks. The `description` property is only for the function-level description.