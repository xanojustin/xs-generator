# Design Hit Counter

## Problem

Design a hit counter which counts the number of hits received in the past 5 minutes (300 seconds).

Your hit counter should support two methods:
- **hit(timestamp)**: Record a hit that happened at the given `timestamp` (in seconds past epoch)
- **getHits(timestamp)**: Return the number of hits in the past 5 minutes from the given `timestamp` (including hits at `timestamp`)

### Constraints
- It is guaranteed that calls are made to the system in chronological order (i.e., timestamps are non-decreasing)
- Several hits may arrive roughly at the same time
- Every timestamp will be a positive integer

This is a classic system design interview question that tests your ability to design a data structure for time-series data with efficient insertion and range queries.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test operations that simulate hits and queries
- **Function (`function/hit_counter.xs`):** Contains the hit counter implementation logic
- **Table (`table/hits.xs`):** Stores the hit timestamps persistently

## Function Signature

- **Input:** 
  - `test_operations` (object[]): Array of operations to perform, where each operation has:
    - `action` (text): Either `"hit"` to record a hit or `"getHits"` to query the count
    - `timestamp` (int): The timestamp in seconds

- **Output:** 
  - Array of results for each operation:
    - For `"hit"`: `{ action: "hit", timestamp: number, status: "recorded" }`
    - For `"getHits"`: `{ action: "getHits", timestamp: number, window_start: number, count: number }`

## Test Cases

The run job executes the following test operations:

| Operation | Timestamp | Description |
|-----------|-----------|-------------|
| hit | 1 | Record hit at time 1 |
| hit | 2 | Record hit at time 2 |
| hit | 3 | Record hit at time 3 |
| getHits | 4 | Query: should return 3 (hits at 1, 2, 3 are all within [4-300, 4]) |
| hit | 300 | Record hit at time 300 |
| getHits | 300 | Query: should return 4 (hits at 1, 2, 3, 300 are within [0, 300]) |
| getHits | 301 | Query: should return 4 (hits at 2, 3, 300 are within [1, 301]; hit at 1 is now out of window) |

## Example Walkthrough

```
hit(1);        // System: [1]
hit(2);        // System: [1, 2]
hit(3);        // System: [1, 2, 3]
getHits(4);    // Returns 3 (all hits within [4-300, 4] = [-296, 4])
hit(300);      // System: [1, 2, 3, 300]
getHits(300);  // Returns 4 (all hits within [0, 300])
getHits(301);  // Returns 4 (hits within [1, 301] = [1, 2, 3, 300])
               // Wait - actually hit(1) is at timestamp 1, so at 301 the window is [1, 301]
               // Hit at 1 is included! Let me recalculate...
```

Actually, let me correct:
- At timestamp 301, the 5-minute window is [301-300, 301] = [1, 301]
- So hits at 1, 2, 3, 300 are all within [1, 301]
- Result: 4 hits

## Design Considerations

In a production system, you might consider:
- **Memory optimization**: For high-traffic systems, storing every hit individually may consume too much memory. Consider bucketing hits into time windows (e.g., 1-second buckets).
- **Cleanup**: Old hits outside the 5-minute window could be periodically cleaned up to prevent unbounded growth.
- **Concurrency**: The current design assumes sequential access. For concurrent access, you'd need proper locking mechanisms.

## XanoScript Implementation Notes

This solution demonstrates:
- Using database tables for stateful operations in XanoScript
- Processing arrays of operations with `foreach` loops
- Conditional logic with `if`/`elseif`
- Database queries with `where` clauses for range filtering
- Building response objects incrementally
