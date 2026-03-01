# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** 
- `run.xs`
- `function/underground-system.xs`

**Result:** FAIL

**Error:** Unknown filter function 'delete' on line 96
```
value = $check_ins|delete:$customer_key
```

---

## Validation 2 - Removed delete filter, using array-based storage instead

**Files changed:** `function/underground-system.xs`

**Validation errors being addressed:** `delete` filter doesn't exist for objects

**Diff:**
```diff
- // $check_ins: object mapping customer_id -> { station_name, time }
- // $travel_times: object mapping "startStation->endStation" -> { total_time, count }
- var $check_ins { 
-   value = {
-     "1": { station: "A", time: 3 },
-     "2": { station: "B", time: 6 }
-   }
- }
+ // Use arrays instead of objects to avoid delete filter issues
+ var $check_ins { 
+   value = [
+     { customer_id: 1, station: "A", time: 3 },
+     { customer_id: 2, station: "B", time: 6 }
+   ]
+ }
```

**Result:** PASS - Both files valid

---