# Clone Graph

## Problem
Given a reference of a node in a **connected undirected graph**, return a **deep copy** (clone) of the graph.

Each node contains:
- `val`: An integer value
- `neighbors`: An array of adjacent nodes

The graph is represented using an adjacency list representation. The clone should be a completely new graph with no shared references to the original nodes.

**Key Challenge:** Handle cycles in the graph. Since the graph is undirected and connected, traversing without tracking visited nodes will cause infinite recursion.

## Structure
- **Run Job (`run.xs`):** Calls the solution function with test input
- **Function (`function/clone-graph.xs`):** Contains the solution logic using iterative DFS with a hash map to track visited nodes

## Function Signature
- **Input:** 
  - `node` (object): The starting node of the graph with properties:
    - `val` (int): The node's value
    - `neighbors` (object[]): Array of adjacent node objects
- **Output:** 
  - (object): A deep cloned copy of the starting node, with all connected nodes also cloned

## Algorithm
1. Use a hash map to track original node values to their cloned counterparts
2. Use iterative DFS with an explicit stack to traverse the graph
3. For each node:
   - If already cloned (in map), skip
   - Otherwise, create a new node and add to map
   - Process neighbors: if already cloned, add reference; if not, push to stack
4. Return the cloned starting node from the map

## Test Cases

| Input | Expected Output |
|-------|-----------------|
| Graph: 1 connected to 2,4; 2 connected to 1,3; 3 connected to 2,4; 4 connected to 1,3 | Deep copy with same structure, no shared references |
| `null` | `null` |

### Test Details

**Test 1: 4-node connected graph**
- Input: Node 1 with neighbors forming a cycle through nodes 2, 3, and 4
- Graph structure: 1-2-3-4-1 (cycle)
- Expected: Cloned graph with identical connectivity, no reference sharing with original

**Test 2: Null input (handled via conditional)**
- Input: `null`
- Expected: `null` returned immediately
