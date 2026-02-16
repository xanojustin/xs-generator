function "convert_file" {
  input {
    text input_url
    text output_format
    text filename
  }
  stack {
    // Validate inputs
    precondition ($input.input_url != null && $input.input_url != "") {
      error_type = "inputerror"
      error = "input_url is required"
    }
    
    precondition ($input.output_format != null && $input.output_format != "") {
      error_type = "inputerror"
      error = "output_format is required"
    }
    
    precondition ($input.filename != null && $input.filename != "") {
      error_type = "inputerror"
      error = "filename is required"
    }

    // Create the conversion job
    var $job_payload {
      value = {
        tasks: {
          "import-file": {
            operation: "import/url",
            url: $input.input_url
          },
          "convert-file": {
            operation: "convert",
            input: "import-file",
            output_format: $input.output_format
          },
          "export-file": {
            operation: "export/url",
            input: "convert-file"
          }
        }
      }
    }

    api.request {
      url = "https://api.cloudconvert.com/v2/jobs"
      method = "POST"
      params = $job_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $env.cloudconvert_api_key
      ]
      timeout = 30
    } as $create_response

    precondition ($create_response.response.status == 201) {
      error_type = "standard"
      error = "Failed to create conversion job: " ~ ($create_response.response.result|json_encode)
    }

    var $job_id { value = $create_response.response.result.data.id }
    var $job_status { value = $create_response.response.result.data.status }

    // Store the conversion job in the database
    db.add "conversion" {
      data = {
        job_id: $job_id,
        input_url: $input.input_url,
        output_format: $input.output_format,
        output_filename: null,
        output_url: null,
        status: $job_status,
        created_at: now
      }
    } as $conversion_record

    // Prepare response
    var $result {
      value = {
        success: true,
        job_id: $job_id,
        status: $job_status,
        record_id: $conversion_record.id,
        message: "Conversion job created successfully. Use the job_id to check status."
      }
    }
  }
  response = $result
}
