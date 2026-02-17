function "run_demo" {
  description = "Run a demonstration of Redis cache operations"
  input {}
  stack {
    var $demo_key { value = "demo:counter:" ~ (now|to_text) }
    var $demo_value { value = { message: "Hello from Redis!", timestamp: now } }
    
    redis.set {
      key = $demo_key
      data = $demo_value
      ttl = 300
    }
    
    redis.get { key = $demo_key } as $retrieved
    
    redis.incr {
      key = $demo_key ~ ":count"
      by = 5
    } as $count_after_incr
    
    redis.decr {
      key = $demo_key ~ ":count"
      by = 2
    } as $count_after_decr
    
    redis.has { key = $demo_key } as $exists
    
    redis.del { key = $demo_key }
    
    redis.has { key = $demo_key } as $exists_after_delete
  }
  response = {
    demo: "Redis Cache Operations",
    operations: [
      { step: 1, action: "set", key: $demo_key, status: "completed" },
      { step: 2, action: "get", key: $demo_key, found: ($retrieved != null) },
      { step: 3, action: "incr", key: ($demo_key ~ ":count"), by: 5, result: $count_after_incr },
      { step: 4, action: "decr", key: ($demo_key ~ ":count"), by: 2, result: $count_after_decr },
      { step: 5, action: "has (before delete)", key: $demo_key, exists: $exists },
      { step: 6, action: "delete", key: $demo_key, status: "completed" },
      { step: 7, action: "has (after delete)", key: $demo_key, exists: $exists_after_delete }
    ],
    summary: "All Redis operations executed successfully"
  }
}
