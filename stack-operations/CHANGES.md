# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** `run.xs`, `function/stack_operations.xs`
**Result:** FAIL (3 errors)

### Errors Found:
1. `[Line 9, Column 80]` The argument 'optional' is not valid in this context
2. `[Line 9, Column 80]` Expected value of `optional` to be `null`
3. `[Line 80, Column 9]` Expecting --> } <-- but found --> 'error' <--

### Issues Identified:
- Used `optional = true` syntax which is not valid XanoScript
- Used `error "message"` statement which is not valid XanoScript

---

## Validation 2 - Fixed optional input and error handling

**Files changed:** `function/stack_operations.xs`

**Validation errors being addressed:**
1. `optional = true` is not valid input syntax
2. `error "message"` is not valid error handling

**Diff:**
```diff
   input {
     text[] stack { description = "Initial stack array (bottom to top order)" }
     text operation { description = "Operation to perform: push, pop, or peek" }
-    text value { description = "Value to push (only used for push operation)", optional = true }
+    text value { description = "Value to push (only used for push operation)" }
   }
```

```diff
   stack {
     // Get the current stack size
     var $stack_size { value = $input.stack|count }
+    var $result { value = null }
+    var $error_msg { value = null }
```

```diff
-        precondition ($input.value != null) {
-          error_type = "standard"
-          error = "Value is required for push operation"
-        }
-        
-        var $new_stack {
-          value = $input.stack|merge:[$input.value]
-        }
-        var $result {
-          value = {
-            stack: $new_stack,
-            top: $input.value,
-            size: $stack_size + 1,
-            operation: "push"
+        conditional {
+          if ($input.value == null) {
+            var $error_msg { value = "Value is required for push operation" }
+          }
+          else {
+            var $new_stack {
+              value = $input.stack|merge:[$input.value]
+            }
+            var $result {
+              value = {
+                stack: $new_stack,
+                top: $input.value,
+                size: $stack_size + 1,
+                operation: "push"
+              }
+            }
           }
         }
```

```diff
-      // Invalid operation
-      else {
-        error "Invalid operation: " ~ $input.operation ~ ". Use 'push', 'pop', or 'peek'."
-      }
+      // Invalid operation
+      else {
+        var $error_msg { value = "Invalid operation: " ~ $input.operation ~ ". Use 'push', 'pop', or 'peek'." }
+      }
```

```diff
-  response = $result
+  response = {
+    success: $error_msg == null,
+    result: $result,
+    error: $error_msg
+  }
```

**Result:** PASS (2 valid files, 0 invalid)

---

## Summary

The main learning was that XanoScript does not support:
1. `optional = true` in input blocks - all inputs are effectively optional unless validated in the stack
2. `error "message"` statements - instead use `var $error_msg` with conditional checks
3. `precondition` blocks for validation - use conditional/if statements instead

The pattern used in other exercises (like queue_operations) is the correct approach:
- Define all inputs without optional markers
- Use `var $error_msg` to track errors
- Use conditional statements to validate and set error messages
- Return a structured response with success/error fields
