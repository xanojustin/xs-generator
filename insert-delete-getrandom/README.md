# Insert Delete GetRandom O(1)

## Problem

Implement the `RandomizedSet` class:

- `RandomizedSet()` Initializes the `RandomizedSet` object.
- `bool insert(int val)` Inserts an item `val` into the set if not present. Returns `true` if the item was not present, `false` otherwise.
- `bool remove(int val)` Removes an item `val` from the set if present. Returns `true` if the item was present, `false` otherwise.
- `int getRandom()` Returns a random element from the current set of elements (it's guaranteed that at least one element exists when this method is called). Each element must have the **same probability** of being returned.

You must implement the functions of the class such that each function works in **average O(1)** time complexity.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/randomized_set.xs`):** Contains the RandomizedSet implementation logic

## Function Signature

- **Input:**
  - `operations` (text[]): Array of operation names: "insert", "remove", or "getRandom"
  - `values` (json[]): Array of values corresponding to each operation (null for getRandom)
  
- **Output:**
  - Returns a boolean[]/int[] mixed array with results for each operation:
    - `insert` returns `true` if value was added, `false` if already exists
    - `remove` returns `true` if value was removed, `false` if didn't exist
    - `getRandom` returns a random element from the set

## Approach

The key insight is to combine two data structures:

1. **Array (`data_array`)**: Stores the actual values for O(1) getRandom access
2. **Hash Map (`index_map`)**: Maps values to their indices in the array for O(1) lookups

### Insert Operation O(1)
1. Check if value exists in index_map
2. If not, append to array and store index in map

### Remove Operation O(1)
1. Find index of value to remove from index_map
2. Get the last element in the array
3. Swap the element to remove with the last element
4. Update the index_map for the swapped element
5. Remove the last element from array and delete from map

### GetRandom Operation O(1)
Simply return a random element from the array.

## Test Cases

| Input Operations | Input Values | Expected Output |
|-----------------|--------------|-----------------|
| ["insert", "insert", "insert", "getRandom", "remove", "getRandom"] | [1, 2, 3, null, 2, null] | [true, true, true, 1 or 2 or 3, true, 1 or 3] |
| ["insert", "remove", "insert", "getRandom"] | [1, 1, 2, null] | [true, true, true, 2] |
| ["insert", "insert", "remove", "insert", "getRandom"] | [1, 2, 1, 2, null] | [true, true, true, false, 2] |

### Edge Cases

| Input Operations | Input Values | Expected Output | Description |
|-----------------|--------------|-----------------|-------------|
| ["insert", "insert"] | [1, 1] | [true, false] | Duplicate insert returns false |
| ["remove"] | [1] | [false] | Remove from empty set returns false |
| ["insert", "getRandom"] | [1, null] | [true, 1] | Single element always returned |

## Complexity Analysis

| Operation | Time Complexity | Space Complexity |
|-----------|----------------|------------------|
| Insert    | O(1) average   | O(n)             |
| Remove    | O(1) average   | O(n)             |
| GetRandom | O(1)           | O(n)             |

Where n is the number of elements in the set.