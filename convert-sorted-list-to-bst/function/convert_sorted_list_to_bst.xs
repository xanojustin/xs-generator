function "convert_sorted_list_to_bst" {
  description = "Convert a sorted linked list to a height-balanced Binary Search Tree"
  input {
    int[] head { description = "Array representing sorted linked list values" }
  }
  stack {
    // Helper: build BST recursively from array range
    var $start { value = 0 }
    var $end { value = ($input.head|count) - 1 }
    
    function.run "build_bst_helper" {
      input = {
        values: $input.head
        start: $start
        end: $end
      }
    } as $result
  }
  response = $result
}
