# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:**
- `/Users/justinalbrecht/xs/design-bank-system/run.xs`
- `/Users/justinalbrecht/xs/design-bank-system/function/bank-system.xs`

**Result:** FAIL

**Validation errors:**
```
✗ bank-system.xs: Found 1 error(s):

1. [Line 17, Column 15] Expecting: Expected an expression
but found: '{'

Code at line 17:
  value = {
```

---

## Validation 2 - Fixed object literal syntax

**Files changed:**
- `/Users/justinalbrecht/xs/design-bank-system/function/bank-system.xs`

**Validation errors being addressed:**
- Object literal syntax was incorrect - used `{ key: { nested } }` instead of proper syntax
- Numeric keys in objects need to be accessed properly with `get`/`set` filters
- Chained object access was incorrect

**Diff:**
```diff
-     var $accounts { 
-       value = {
-         1: { balance: 1000 },
-         2: { balance: 500 },
-         3: { balance: 0 }
-       }
-     }
-     ...
-     value = $accounts[$input.account_id|to_text].balance
+     var $account_key { value = $input.account_id|to_text }
+     ...
+     value = $accounts|get:$account_key|get:"balance"
```

Also changed object access patterns throughout to use proper `get` and `set` filter syntax:
```diff
- value = $accounts[$input.account_id|to_text].balance
+ value = $accounts|get:$account_key|get:"balance"

- value = $accounts|merge:{
-     [$input.account_id|to_text]: { balance: $new_balance }
- }
+ var $account_obj { value = { balance: $new_balance } }
+ value = $accounts|set:$account_key:$account_obj
```

**Result:** PASS

**Files validated:**
- `/Users/justinalbrecht/xs/design-bank-system/run.xs` ✅
- `/Users/justinalbrecht/xs/design-bank-system/function/bank-system.xs` ✅

Both files passed validation with no errors.
