# CHANGES.md - Code Evolution Between Validations

## Validation 1 - Initial

**Files validated:** run.xs, function/find_median_from_data_stream.xs, function/find_median_sorted.xs
**Result:** FAIL - 2 errors in find_median_sorted.xs

**Errors:**
1. [Line 27, Column 35] Unknown filter function 'array_replace'
2. [Line 27, Column 52] Expecting --> } <-- but found --> '$sorted' <--

**Code at error line:**
```
value = $sorted|array_replace:$j,$sorted[$j + 1]
```

---

## Validation 2 - Fixed array swap logic

**Files changed:** function/find_median_sorted.xs
**Validation errors being addressed:** `array_replace` filter does not exist in XanoScript

**Diff:**
```diff
-          // Sort the array using a simple bubble sort
-          var $sorted { value = $input.arr }
-          var $i { value = 0 }
- 
-          while ($i < $n) {
-            each {
-              var $j { value = 0 }
-              while ($j < ($n - $i - 1)) {
-                each {
-                  conditional {
-                    if ($sorted[$j] > $sorted[$j + 1]) {
-                      // Swap elements
-                      var $temp { value = $sorted[$j] }
-                      var $sorted {
-                        value = $sorted|array_replace:$j,$sorted[$j + 1]
-                      }
-                      var $sorted {
-                        value = $sorted|array_replace:($j + 1),$temp
-                      }
-                    }
-                  }
-                  var.update $j { value = $j + 1 }
-                }
-              }
-              var.update $i { value = $i + 1 }
-            }
-          }
+          // Sort the array using bubble sort with array rebuilding
+          var $sorted { value = $input.arr }
+          var $i { value = 0 }
+
+          while ($i < $n) {
+            each {
+              var $j { value = 0 }
+              while ($j < ($n - $i - 1)) {
+                each {
+                  // Check if we need to swap
+                  conditional {
+                    if ($sorted[$j] > $sorted[$j + 1]) {
+                      // Rebuild array with swapped elements
+                      var $new_sorted { value = [] }
+                      var $k { value = 0 }
+
+                      // Copy elements before swap position
+                      while ($k < $j) {
+                        each {
+                          var $new_sorted {
+                            value = $new_sorted ~ [$sorted[$k]]
+                          }
+                          var.update $k { value = $k + 1 }
+                        }
+                      }
+
+                      // Add swapped elements in reverse order
+                      var $new_sorted {
+                        value = $new_sorted ~ [$sorted[$j + 1]]
+                      }
+                      var $new_sorted {
+                        value = $new_sorted ~ [$sorted[$j]]
+                      }
+
+                      // Update k to continue after swapped elements
+                      var $k { value = $j + 2 }
+
+                      // Copy remaining elements
+                      while ($k < $n) {
+                        each {
+                          var $new_sorted {
+                            value = $new_sorted ~ [$sorted[$k]]
+                          }
+                          var.update $k { value = $k + 1 }
+                        }
+                      }
+
+                      var $sorted { value = $new_sorted }
+                    }
+                  }
+                  var.update $j { value = $j + 1 }
+                }
+              }
+              var.update $i { value = $i + 1 }
+            }
+          }
```

**Result:** PASS - All 3 files validated successfully

---
