function "moderate_content" {
  input {
    text content
    text model = "omni-moderation-latest"
  }
  
  stack {
    // Call OpenAI Moderation API
    request post {
      url = "https://api.openai.com/v1/moderations"
      headers = {
        "Authorization": "Bearer " + $env.openai_api_key
        "Content-Type": "application/json"
      }
      body = {
        "input": $input.content
        "model": $input.model
      }
    } as $moderation_response

    // Extract the results
    $moderation_response.results[0] as $result

    // Build the response
    {
      "flagged": $result.flagged
      "categories": $result.categories
      "category_scores": $result.category_scores
      "max_score": $result.category_scores|values|max
      "model": $input.model
      "checked_at": now
    } as $output

    // Log if content is flagged
    condition $result.flagged == true {
      log warning "Content flagged by moderation: " + $input.content|truncate(100)
    }
  }
  
  response = $output
}
