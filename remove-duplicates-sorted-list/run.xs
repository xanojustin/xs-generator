// Run job to test the remove_duplicates_sorted_list function
// Remove Duplicates from Sorted List: Given a sorted linked list, delete all duplicates
// so each element appears only once, returning the modified list
run.job "Test Remove Duplicates from Sorted List" {
  main = {
    name: "remove_duplicates_sorted_list"
    input: {
      list: [
        { value: 1, next: 1 },
        { value: 1, next: 2 },
        { value: 2, next: 3 },
        { value: 3, next: 4 },
        { value: 3, next: null }
      ]
      head_index: 0
    }
  }
}
