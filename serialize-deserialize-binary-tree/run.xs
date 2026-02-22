run.job "Serialize Deserialize Binary Tree" {
  main = {
    name: "serialize_deserialize_tree"
    input: {
      tree: {
        val: 1,
        left: { val: 2, left: null, right: null },
        right: {
          val: 3,
          left: { val: 4, left: null, right: null },
          right: { val: 5, left: null, right: null }
        }
      }
    }
  }
}