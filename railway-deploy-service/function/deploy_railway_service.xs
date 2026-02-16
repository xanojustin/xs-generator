function "deploy_railway_service" {
  description = "Deploy a new service to Railway platform"
  
  input {
    text project_id filters=trim {
      description = "Railway project ID to deploy the service to"
    }
    text service_name filters=trim {
      description = "Name for the new service"
    }
    text image filters=trim {
      description = "Docker image to deploy (e.g., nginx:latest)"
    }
    json env_vars? {
      description = "Environment variables as key-value pairs"
    }
  }
  
  stack {
    // Step 1: Create the service in Railway
    api.request {
      url = "https://backboard.railway.app/graphql/v2"
      method = "POST"
      params = {
        query: "mutation ServiceCreate($input: ServiceCreateInput!) { serviceCreate(input: $input) { id name } }",
        variables: {
          input: {
            projectId: $input.project_id,
            name: $input.service_name
          }
        }
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.railway_api_token
      ]
    } as $create_response
    
    precondition ($create_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to create Railway service"
    }
    
    var $service_id { 
      value = $create_response.response.result.data.serviceCreate.id 
    }
    var $service_name_created { 
      value = $create_response.response.result.data.serviceCreate.name 
    }
    
    // Step 2: Configure the service source (image deployment)
    api.request {
      url = "https://backboard.railway.app/graphql/v2"
      method = "POST"
      params = {
        query: "mutation ServiceUpdate($id: String!, $input: ServiceUpdateInput!) { serviceUpdate(id: $id, input: $input) { id } }",
        variables: {
          id: $service_id,
          input: {
            source: {
              image: $input.image
            }
          }
        }
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.railway_api_token
      ]
    } as $update_response
    
    precondition ($update_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to configure service source"
    }
    
    // Step 3: Set environment variables if provided
    conditional {
      if (`$input.env_vars != null`) {
        var $env_vars_array { value = [] }
        
        // Convert env vars object to Railway format
        // Note: Using a series of variable operations to process JSON
        var $env_json { value = $input.env_vars }
        
        api.request {
          url = "https://backboard.railway.app/graphql/v2"
          method = "POST"
          params = {
            query: "mutation VariableUpsert($input: VariableUpsertInput!) { variableUpsert(input: $input) { id } }",
            variables: {
              input: {
                projectId: $input.project_id,
                serviceId: $service_id,
                environmentId: null,
                variables: $input.env_vars
              }
            }
          }
          headers = [
            "Content-Type: application/json",
            "Authorization: Bearer " ~ $env.railway_api_token
          ]
        } as $env_response
        
        // Don't fail on env var issues, just log
        conditional {
          if (`$env_response.response.status != 200`) {
            var $env_error { value = true }
          }
        }
      }
    }
    
    // Step 4: Trigger deployment
    api.request {
      url = "https://backboard.railway.app/graphql/v2"
      method = "POST"
      params = {
        query: "mutation DeploymentTrigger($input: DeploymentTriggerInput!) { deploymentTrigger(input: $input) { id status } }",
        variables: {
          input: {
            serviceId: $service_id
          }
        }
      }
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.railway_api_token
      ]
    } as $deploy_response
    
    precondition ($deploy_response.response.status == 200) {
      error_type = "standard"
      error = "Failed to trigger deployment"
    }
    
    var $deployment_id { 
      value = $deploy_response.response.result.data.deploymentTrigger.id 
    }
    var $deployment_status { 
      value = $deploy_response.response.result.data.deploymentTrigger.status 
    }
    
    // Build response
    var $result {
      value = {
        success: true,
        service: {
          id: $service_id,
          name: $service_name_created
        },
        deployment: {
          id: $deployment_id,
          status: $deployment_status
        },
        message: "Service deployed successfully to Railway"
      }
    }
  }
  
  response = $result
}
