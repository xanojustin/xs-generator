# Circular Buffer (Ring Buffer)

## Problem

A circular buffer (also known as a ring buffer) is a fixed-size data structure that uses a single, fixed-size buffer as if it were connected end-to-end. When the buffer is full and a new item is written, it overwrites the oldest data (FIFO behavior with circular wrap-around).

Implement a circular buffer with the following operations:
- **write**: Add an item to the buffer. If the buffer is full, overwrite the oldest item.
- **read**: Remove and return the oldest item from the buffer.
- **clear**: Empty the buffer and reset indices.
- **isFull**: Check if the buffer has reached its capacity.
- **isEmpty**: Check if the buffer contains no items.
- **size**: Return the number of items currently in the buffer.
- **capacity**: Return the maximum capacity of the buffer.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with test inputs to write items to the buffer
- **Function (`function/circular_buffer.xs`):** Contains the circular buffer implementation with all operations

## Function Signature

- **Input:**
  - `operation` (text): The operation to perform ('read', 'write', 'clear', 'isFull', 'isEmpty', 'size', 'capacity')
  - `capacity` (int): Maximum capacity of the buffer
  - `buffer` (json): Current buffer state as an array
  - `read_index` (json): Index for reading (position of oldest item)
  - `write_index` (json): Index for writing (next position to write)
  - `item` (json): Item to write (required for 'write' operation)

- **Output:**
  - `success` (bool): Whether the operation succeeded
  - `result`: The operation result (item for read, boolean for write/clear/isFull/isEmpty, int for size/capacity)
  - `error` (text): Error message if operation failed
  - `buffer` (json): Updated buffer state
  - `read_index` (json): Updated read index
  - `write_index` (json): Updated write index
  - `capacity` (json): Buffer capacity

## Test Cases

| Operation | Input State | Expected Output |
|-----------|-------------|-----------------|
| write 10 to empty buffer (cap 3) | `[]`, `read=0`, `write=0` | success=true, buffer=[10,null,null], write=1 |
| write 20, 30 | buffer=[10,null,null] | success=true, buffer=[10,20,30], write=0 |
| isFull after 3 writes | buffer=[10,20,30] | result=true |
| read from buffer | buffer=[10,20,30], read=0 | result=10, buffer=[null,20,30], read=1 |
| write 40 (overwrite oldest) | buffer=[null,20,30], write=0 | buffer=[40,20,30], read=2 (oldest now 20) |
| read until empty | buffer=[40,20,30] | reads 20, then 40, then error |
| isEmpty on empty buffer | buffer=[null,null,null] | result=true |
| clear buffer | buffer=[10,20,30] | buffer=[null,null,null], read=0, write=0 |
| read from empty | buffer=[null,null,null] | success=false, error="Cannot read from empty buffer" |
| write without item | operation=write, no item | success=false, error="Item is required" |
