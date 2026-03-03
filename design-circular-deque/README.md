# Design Circular Deque

## Problem

Design your implementation of the circular double-ended queue (deque).

Implement the `MyCircularDeque` class:

- `MyCircularDeque(k)` - Initializes the deque with a maximum size of `k`.
- `insertFront()` - Adds an item at the front of Deque. Returns `true` if the operation is successful, or `false` otherwise.
- `insertLast()` - Adds an item at the rear of Deque. Returns `true` if the operation is successful, or `false` otherwise.
- `deleteFront()` - Deletes an item from the front of Deque. Returns `true` if the operation is successful, or `false` otherwise.
- `deleteLast()` - Deletes an item from the rear of Deque. Returns `true` if the operation is successful, or `false` otherwise.
- `getFront()` - Gets the front item from the Deque. Returns `-1` if the deque is empty.
- `getRear()` - Gets the last item from the Deque. Returns `-1` if the deque is empty.
- `isEmpty()` - Returns `true` if the deque is empty, or `false` otherwise.
- `isFull()` - Returns `true` if the deque is full, or `false` otherwise.

You must solve this problem using only an array (or a fixed-size buffer) with O(1) time complexity for each operation.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/circularDeque.xs`):** Contains the solution logic

## Function Signature

- **Input:**
  - `capacity` (int): Maximum capacity of the circular deque
  - `operation` (text): Operation to perform (create, insertFront, insertLast, deleteFront, deleteLast, getFront, getRear, isEmpty, isFull)
  - `value` (int, optional): Value to insert for insert operations
- **Output:**
  - Object containing the operation result (success boolean, value, or current state)

## Test Cases

| Operation | Parameters | Expected Output |
|-----------|------------|-----------------|
| create | k=3 | `{ success: true, capacity: 3, size: 0 }` |
| insertLast | 1 | `true` |
| insertLast | 2 | `true` |
| insertFront | 3 | `true` |
| insertFront | 4 | `false` (deque is full) |
| getRear | - | `2` |
| isFull | - | `true` |
| deleteLast | - | `true` |
| insertFront | 4 | `true` |
| getFront | - | `4` |

### Test Case Descriptions

1. **Create deque:** Initialize a deque with capacity 3
2. **Insert operations:** Add elements from both ends (Last and Front)
3. **Full deque:** Attempt to insert when full returns false
4. **Access operations:** Get elements from front and rear
5. **Delete operation:** Remove from rear makes space
6. **Insert after delete:** Successfully insert at front after deletion

## Complexity Analysis

- **Time Complexity:** O(1) for all operations
- **Space Complexity:** O(k) where k is the capacity of the deque

## Implementation Notes

The circular deque uses modulo arithmetic to wrap around the fixed-size array:
- `front = (front - 1 + capacity) % capacity` for insertFront
- `rear = (rear + 1) % capacity` for insertLast
- `front = (front + 1) % capacity` for deleteFront
- `rear = (rear - 1 + capacity) % capacity` for deleteLast
