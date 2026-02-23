# Find Median from Data Stream

## Problem
Given a stream of integers, calculate the median after each number is added to the stream.

The **median** is the middle value in an ordered integer list. If the list length is even, the median is the average of the two middle values.

For example:
- After adding [5], median = 5
- After adding [5, 2], sorted = [2, 5], median = (2+5)/2 = 3.5
- After adding [5, 2, 8], sorted = [2, 5, 8], median = 5

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test inputs
- **Function (`function/find_median_from_data_stream.xs`):** Contains the main solution logic
- **Helper Function (`function/find_median_sorted.xs`):** Sorts array and calculates median

## Function Signature
- **Input:** `stream` - An array of integers representing the data stream
- **Output:** An array of decimal values representing the median after each number is added

## Test Cases

| Input Stream | Expected Output |
|--------------|-----------------|
| [5, 2, 8, 1, 7] | [5, 3.5, 5, 3.5, 5] |
| [1, 2, 3, 4, 5] | [1, 1.5, 2, 2.5, 3] |
| [42] | [42] |
| [10, 20] | [10, 15] |

### Explanation of Test Cases:

**Case 1: [5, 2, 8, 1, 7]**
- After 5: sorted=[5], median=5
- After 5,2: sorted=[2,5], median=(2+5)/2=3.5
- After 5,2,8: sorted=[2,5,8], median=5
- After 5,2,8,1: sorted=[1,2,5,8], median=(2+5)/2=3.5
- After 5,2,8,1,7: sorted=[1,2,5,7,8], median=5

**Case 2: [1, 2, 3, 4, 5]**
- After each step: [1], [1.5], [2], [2.5], [3]

**Case 3: [42]**
- Single element: median = 42

**Case 4: [10, 20]**
- After 10: median=10
- After 10,20: sorted=[10,20], median=(10+20)/2=15
