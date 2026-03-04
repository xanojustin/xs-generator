function "test_runner" {
  description = "Run test cases for largest BST subtree solution"
  
  input {
  }
  
  stack {
    // Test Case 1: Partial BST tree
    //       10
    //      /  \
    //     5    15
    //    / \     \
    //   1   8     7  <- invalid BST here (7 < 15)
    var $tree1 {
      value = {
        val: 10,
        left: {
          val: 5,
          left: { val: 1 },
          right: { val: 8 }
        },
        right: {
          val: 15,
          right: { val: 7 }
        }
      }
    }
    
    function.run "largest_bst_subtree" {
      input = { tree: $tree1 }
    } as $result1
    
    debug.log {
      value = "Test 1 (Partial BST): Expected 3, Got: " ~ ($result1|to_text)
    }
    
    // Test Case 2: Empty tree
    function.run "largest_bst_subtree" {
      input = { tree: null }
    } as $result2
    
    debug.log {
      value = "Test 2 (Empty tree): Expected 0, Got: " ~ ($result2|to_text)
    }
    
    // Test Case 3: Single node
    var $tree3 {
      value = { val: 5 }
    }
    
    function.run "largest_bst_subtree" {
      input = { tree: $tree3 }
    } as $result3
    
    debug.log {
      value = "Test 3 (Single node): Expected 1, Got: " ~ ($result3|to_text)
    }
    
    // Test Case 4: Valid BST - full tree is BST
    //       5
    //      / \
    //     3   8
    //    /
    //   1
    var $tree4 {
      value = {
        val: 5,
        left: {
          val: 3,
          left: { val: 1 }
        },
        right: { val: 8 }
      }
    }
    
    function.run "largest_bst_subtree" {
      input = { tree: $tree4 }
    } as $result4
    
    debug.log {
      value = "Test 4 (Valid BST): Expected 4, Got: " ~ ($result4|to_text)
    }
    
    // Test Case 5: Only leaf nodes form BST
    //       10
    //      /  \
    //     15   20  <- invalid BST (both > 10)
    var $tree5 {
      value = {
        val: 10,
        left: { val: 15 },
        right: { val: 20 }
      }
    }
    
    function.run "largest_bst_subtree" {
      input = { tree: $tree5 }
    } as $result5
    
    debug.log {
      value = "Test 5 (Only leaves valid): Expected 1, Got: " ~ ($result5|to_text)
    }
    
    // Collect results
    var $test_results {
      value = {
        test1_partial_bst: $result1,
        test2_empty: $result2,
        test3_single_node: $result3,
        test4_valid_bst: $result4,
        test5_invalid_root: $result5
      }
    }
  }
  
  response = $test_results
}
