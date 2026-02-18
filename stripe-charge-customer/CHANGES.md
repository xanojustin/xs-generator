# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/charge_customer.xs, table/charge_log.xs
**Result:** FAIL - 1 error in charge_customer.xs
**Validation errors being addressed:** 
```
1. [Line 76, Column 31] Expecting --> } <-- but found --> ',' <--
Code at line 76:
  name = "StripeError",
```
**Code at this point:** (not needed — this is the baseline)

---

## Validation 2 - Fixed throw syntax (removed comma)

**Files changed:** function/charge_customer.xs
**Validation errors being addressed:** 
```
1. [Line 76, Column 31] Expecting --> } <-- but found --> ',' <--
```
**Diff:**
```
         throw {
-          name = "StripeError",
+          name = "StripeError"
           value = $error_message
         }
```
**Result:** PASS - All 3 files valid

---
