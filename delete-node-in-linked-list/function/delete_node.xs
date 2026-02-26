function "delete_node" {
  description = "Delete a node in a linked list given only access to that node (not the head)"
  input {
    json node
  }
  stack {
    // Since we don't have access to the head, we can't delete the current node directly
    // Instead, we copy the next node's value to the current node, then skip the next node
    // This effectively "deletes" the current node by replacing it with the next node

    // Get the next node's value
    var $next_val {
      value = $input.node.next.val
    }

    // Get the node after next (could be null)
    var $next_next {
      value = $input.node.next.next
    }

    // Build the result node with the next node's value and next pointer
    var $result {
      value = {
        val: $next_val
        next: $next_next
      }
    }
  }
  response = $result
}
