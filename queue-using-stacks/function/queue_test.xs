// Queue using Stacks Test - Comprehensive test cases
function "queue_test" {
  description = "Run all test cases for queue using stacks implementation"
  
  input {}
  
  stack {
    // Test 1: Basic enqueue and dequeue
    debug.log { value = "=== Test 1: Basic Enqueue and Dequeue ===" }
    function.run "queue_using_stacks" {
      input = { operation: "enqueue", payload: 1 }
    } as $t1_enq1
    function.run "queue_using_stacks" {
      input = { operation: "enqueue", payload: 2 }
    } as $t1_enq2
    function.run "queue_using_stacks" {
      input = { operation: "enqueue", payload: 3 }
    } as $t1_enq3
    function.run "queue_using_stacks" {
      input = { operation: "dequeue" }
    } as $t1_deq1
    debug.log { value = "Test 1 - Enqueued 1,2,3 then dequeued. Expected: 1, Got: " ~ ($t1_deq1["value"]|to_text) }
    
    // Test 2: FIFO order verification
    debug.log { value = "=== Test 2: FIFO Order Verification ===" }
    function.run "queue_using_stacks" {
      input = { 
        operation: "batch", 
        payload: [
          { operation: "enqueue", value: "a" },
          { operation: "enqueue", value: "b" },
          { operation: "enqueue", value: "c" },
          { operation: "dequeue" },
          { operation: "dequeue" },
          { operation: "dequeue" }
        ]
      }
    } as $t2_batch
    debug.log { value = "Test 2 - FIFO order check. Results: " ~ ($t2_batch["operations"]|to_text) }
    
    // Test 3: Peek operation
    debug.log { value = "=== Test 3: Peek Operation ===" }
    function.run "queue_using_stacks" {
      input = { 
        operation: "batch",
        payload: [
          { operation: "enqueue", value: 10 },
          { operation: "enqueue", value: 20 },
          { operation: "peek" },
          { operation: "dequeue" },
          { operation: "peek" }
        ]
      }
    } as $t3_peek
    debug.log { value = "Test 3 - Peek test. Results: " ~ ($t3_peek["operations"]|to_text) }
    
    // Test 4: Is empty check
    debug.log { value = "=== Test 4: Is Empty Check ===" }
    function.run "queue_using_stacks" {
      input = { operation: "is_empty" }
    } as $t4_empty1
    function.run "queue_using_stacks" {
      input = { operation: "enqueue", payload: "x" }
    } as $_t4_enq
    function.run "queue_using_stacks" {
      input = { operation: "is_empty" }
    } as $t4_empty2
    debug.log { value = "Test 4 - Empty before enqueue: " ~ ($t4_empty1["is_empty"]|to_text) ~ ", after enqueue: " ~ ($t4_empty2["is_empty"]|to_text) }
    
    // Test 5: Dequeue from empty queue (edge case)
    debug.log { value = "=== Test 5: Dequeue from Empty Queue ===" }
    function.run "queue_using_stacks" {
      input = { 
        operation: "batch",
        payload: [
          { operation: "dequeue" }
        ]
      }
    } as $t5_empty_deq
    debug.log { value = "Test 5 - Dequeue from empty. Result: " ~ ($t5_empty_deq["operations"]|to_text) }
    
    // Test 6: Interleaved operations
    debug.log { value = "=== Test 6: Interleaved Operations ===" }
    function.run "queue_using_stacks" {
      input = {
        operation: "batch",
        payload: [
          { operation: "enqueue", value: 1 },
          { operation: "enqueue", value: 2 },
          { operation: "dequeue" },
          { operation: "enqueue", value: 3 },
          { operation: "dequeue" },
          { operation: "dequeue" },
          { operation: "dequeue" }
        ]
      }
    } as $t6_mixed
    debug.log { value = "Test 6 - Interleaved ops. Results: " ~ ($t6_mixed["operations"]|to_text) }
    
    // Test 7: Single element queue
    debug.log { value = "=== Test 7: Single Element Queue ===" }
    function.run "queue_using_stacks" {
      input = {
        operation: "batch",
        payload: [
          { operation: "enqueue", value: "solo" },
          { operation: "peek" },
          { operation: "dequeue" },
          { operation: "is_empty" }
        ]
      }
    } as $t7_single
    debug.log { value = "Test 7 - Single element. Results: " ~ ($t7_single["operations"]|to_text) }
  }
  
  response = {
    test1_basic: $t1_deq1,
    test2_fifo: $t2_batch,
    test3_peek: $t3_peek,
    test4_is_empty: { before: $t4_empty1, after: $t4_empty2 },
    test5_empty_dequeue: $t5_empty_deq,
    test6_interleaved: $t6_mixed,
    test7_single_element: $t7_single
  }
}
