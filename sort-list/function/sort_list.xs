// Sort List - Sort a linked list using merge sort in O(n log n) time
// Given the head of a linked list, return the list after sorting it in ascending order
function "sort_list" {
  description = "Sorts a linked list using merge sort algorithm"
  
  input {
    json nodes { description = "Array of node objects with value and next properties" }
    int? head_index { description = "Index of the head node in the array (null if empty)" }
  }
  
  stack {
    // Handle empty list or single node
    conditional {
      if ($input.head_index == null || ($input.nodes|count) <= 1) {
        var $result { 
          value = { nodes: $input.nodes, head_index: $input.head_index } 
        }
      }
      else {
        // Call recursive helper to sort the list
        function.run "sort_list_helper" {
          input = { 
            nodes: $input.nodes,
            head: $input.head_index 
          }
        } as $sorted_result
        
        var $result { value = $sorted_result }
      }
    }
  }
  
  response = $result
}
