// Test runner for max_depth_nary_tree function
function "max_depth_nary_tree_tests" {
  description = "Test runner for max_depth_nary_tree function - runs multiple test cases"

  input {
  }

  stack {
    // Test case 1: Empty tree (null) - edge case, should return 0
    function.run "max_depth_nary_tree" {
      input = { tree: null }
    } as $result_null

    // Test case 2: Single node (no children) - edge case, should return 1
    var $single_node {
      value = { val: 1, children: [] }
    }
    function.run "max_depth_nary_tree" {
      input = { tree: $single_node }
    } as $result_single

    // Test case 3: Tree with depth 2
    //       1
    //     / | \
    //    2  3  4
    var $depth2_tree {
      value = {
        val: 1,
        children: [
          { val: 2, children: [] },
          { val: 3, children: [] },
          { val: 4, children: [] }
        ]
      }
    }
    function.run "max_depth_nary_tree" {
      input = { tree: $depth2_tree }
    } as $result_depth2

    // Test case 4: Tree with depth 3
    //       1
    //     /   \
    //    2     3
    //   / \
    //  4   5
    var $depth3_tree {
      value = {
        val: 1,
        children: [
          {
            val: 2,
            children: [
              { val: 4, children: [] },
              { val: 5, children: [] }
            ]
          },
          { val: 3, children: [] }
        ]
      }
    }
    function.run "max_depth_nary_tree" {
      input = { tree: $depth3_tree }
    } as $result_depth3

    // Test case 5: Deep tree with depth 4
    //       1
    //      / \
    //     2   3
    //    /
    //   4
    //  /
    // 5
    var $depth4_tree {
      value = {
        val: 1,
        children: [
          {
            val: 2,
            children: [
              {
                val: 4,
                children: [
                  { val: 5, children: [] }
                ]
              }
            ]
          },
          { val: 3, children: [] }
        ]
      }
    }
    function.run "max_depth_nary_tree" {
      input = { tree: $depth4_tree }
    } as $result_depth4

    // Test case 6: Unbalanced tree - different depths on different branches
    //       1
    //     / | \
    //    2  3  4
    //       |
    //       5
    //       |
    //       6
    var $unbalanced_tree {
      value = {
        val: 1,
        children: [
          { val: 2, children: [] },
          {
            val: 3,
            children: [
              {
                val: 5,
                children: [
                  { val: 6, children: [] }
                ]
              }
            ]
          },
          { val: 4, children: [] }
        ]
      }
    }
    function.run "max_depth_nary_tree" {
      input = { tree: $unbalanced_tree }
    } as $result_unbalanced

    // Compile all results
    var $test_results {
      value = {
        test_null: {
          description: "Empty tree (null)",
          expected: 0,
          actual: $result_null,
          passed: (`$result_null == 0`)
        },
        test_single: {
          description: "Single node",
          expected: 1,
          actual: $result_single,
          passed: (`$result_single == 1`)
        },
        test_depth2: {
          description: "Tree with depth 2",
          expected: 2,
          actual: $result_depth2,
          passed: (`$result_depth2 == 2`)
        },
        test_depth3: {
          description: "Tree with depth 3",
          expected: 3,
          actual: $result_depth3,
          passed: (`$result_depth3 == 3`)
        },
        test_depth4: {
          description: "Deep tree with depth 4",
          expected: 4,
          actual: $result_depth4,
          passed: (`$result_depth4 == 4`)
        },
        test_unbalanced: {
          description: "Unbalanced tree (depth 4 on one branch)",
          expected: 4,
          actual: $result_unbalanced,
          passed: (`$result_unbalanced == 4`)
        }
      }
    }

    // Log results
    debug.log { value = "Max Depth N-ary Tree Test Results:" }
    debug.log { value = $test_results|json_encode }
  }

  response = $test_results
}
