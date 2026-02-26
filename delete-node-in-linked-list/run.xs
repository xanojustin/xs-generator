run.job "Delete Node in Linked List" {
  main = {
    name: "delete_node"
    input: {
      node: {
        val: 4
        next: {
          val: 5
          next: {
            val: 1
            next: {
              val: 9
              next: null
            }
          }
        }
      }
    }
  }
}
