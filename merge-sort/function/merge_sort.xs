// Merge Sort - Classic divide-and-conquer sorting algorithm
// Sorts an array of integers using the merge sort algorithm
function "merge_sort" {
  description = "Sorts an array of integers using merge sort algorithm"
  
  input {
    int[] numbers { description = "Array of integers to sort" }
  }
  
  stack {
    // Handle empty or single element arrays (already sorted)
    conditional {
      if (($input.numbers|count) <= 1) {
        var $sorted { value = $input.numbers }
      }
      else {
        // Call recursive sort function
        function.run "merge_sort_helper" {
          input = { arr: $input.numbers }
        } as $sorted_result
        
        var $sorted { value = $sorted_result }
      }
    }
  }
  
  response = $sorted
}
