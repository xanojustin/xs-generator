// Run job to test the snapshot_array function
run.job "Test Snapshot Array" {
  main = {
    name: "snapshot_array"
    input: {
      length: 3
      operations: [
        { op: "set", index: 0, val: 5 },
        { op: "snap" },
        { op: "set", index: 0, val: 3 },
        { op: "get", index: 0, snap_id: 0 },
        { op: "snap" },
        { op: "get", index: 0, snap_id: 1 }
      ]
    }
  }
}