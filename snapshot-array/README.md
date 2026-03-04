# Snapshot Array

## Problem

Implement a SnapshotArray that supports the following operations:

- `SnapshotArray(int length)`: Initializes an array-like data structure with the given length. Initially, each element equals 0.
- `void set(index, val)`: Sets the element at the given index to be equal to val.
- `int snap()`: Takes a snapshot of the array and returns the snap_id: the total number of times we called snap() minus 1.
- `int get(index, snap_id)`: Returns the value at the given index at the time we took the snapshot with the given snap_id.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/snapshot_array.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `length` (int): The length of the array
  - `operations` (object[]): Array of operations to perform, where each operation has:
    - `op` (text): Operation type - "set", "snap", or "get"
    - `index` (int?): Index for set/get operations
    - `val` (int?): Value for set operation  
    - `snap_id` (int?): Snapshot ID for get operation
- **Output:**
  - Array of integers representing the results of all "get" operations

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| `length: 3, ops: [set(0,5), snap(), set(0,3), get(0,0)]` | `[5]` |
| `length: 1, ops: [snap(), snap(), get(0,0)]` | `[0]` |
| `length: 2, ops: [set(0,1), set(1,2), snap(), get(0,0), get(1,0)]` | `[1, 2]` |
| `length: 3, ops: [set(0,5), snap(), set(0,3), snap(), get(0,0), get(0,1)]` | `[5, 3]` |

### Test Case Descriptions

1. **Basic case:** Set a value, take a snapshot, change the value, then retrieve the old value from the snapshot
2. **Edge case - empty snapshots:** Multiple snapshots without any sets, retrieving default value
3. **Multiple indices:** Setting different values at different indices and retrieving them
4. **Multiple snapshots:** Testing multiple snapshots to ensure correct versioning

## Implementation Notes

The solution uses:
- An object to store array data with index as key
- Each element maintains a history of `[snap_id, value]` pairs
- Binary search for efficient retrieval of historical values
- Efficient space usage by only storing changes, not full array copies