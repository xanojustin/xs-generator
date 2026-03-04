# Time Needed to Inform All Employees

## Problem

A company has `n` employees with a unique ID for each employee from `0` to `n - 1`. The head of the company is the one with `headID`.

Each employee has one direct manager given in the `manager` array where `manager[i]` is the direct manager of the `i`-th employee. The head of the company has no manager, so `manager[headID] = -1`.

The `informTime` array indicates the time (in minutes) it takes for each employee to inform all their direct subordinates. It's guaranteed that all employees can be informed.

Return the number of minutes needed to inform all employees about the urgent news.

## Structure

- **Run Job (`run.xs`):** Calls the solution function with multiple test cases
- **Function (`function/time_needed_to_inform.xs`):** Contains the solution logic using DFS traversal

## Function Signature

- **Input:**
  - `n` (int): Number of employees
  - `headID` (int): ID of the head of the company
  - `manager` (int[]): Array where `manager[i]` is the direct manager of employee `i`
  - `informTime` (int[]): Array where `informTime[i]` is the time employee `i` takes to inform subordinates
  
- **Output:** (int) Total minutes needed to inform all employees

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| n=6, headID=2, manager=[2,2,-1,0,0,1], informTime=[1,1,0,0,0,0] | 2 |
| n=1, headID=0, manager=[-1], informTime=[0] | 0 |
| n=4, headID=0, manager=[-1,0,1,2], informTime=[5,5,5,5] | 15 |
| n=4, headID=0, manager=[-1,0,0,0], informTime=[5,0,0,0] | 5 |

### Test Case Explanations

1. **Basic case:** Employee 2 (head) informs 0 and 1 (1 min). Employee 0 informs 3 and 4 (1 min each). Employee 1 informs 5 (1 min). Longest path = 2 minutes.

2. **Single employee:** Only the head exists, no one to inform. Time = 0.

3. **Chain structure:** A linear hierarchy where each level takes 5 minutes. 0→1→2→3 = 15 minutes total.

4. **Star structure:** Head informs everyone directly. Time = head's informTime = 5 minutes.

## Algorithm

The solution uses Depth-First Search (DFS) to traverse the company hierarchy:

1. Build an adjacency list of subordinates for each manager
2. Use a stack to perform DFS from the head employee
3. Track cumulative time as we traverse down the hierarchy
4. Return the maximum time found across all paths
