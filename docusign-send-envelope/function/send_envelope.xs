function "send_envelope" {
  description = "Create and send a DocuSign envelope for electronic signature"
  input {
    text subject filters=trim { description = "Subject line for the signature request email" }
    text signer_name filters=trim { description = "Full name of the signer" }
    text signer_email filters=trim { description = "Email address of the signer" }
    text document_base64 filters=trim { description = "Base64-encoded document content" }
    text document_name?="document.pdf" filters=trim { description = "Name of the document file" }
    text document_file_extension?="pdf" filters=trim { description = "File extension (pdf, docx, etc.)" }
  }

  stack {
    // Get environment variables
    var $account_id { value = $env.DOCUSIGN_ACCOUNT_ID }
    var $access_token { value = $env.DOCUSIGN_ACCESS_TOKEN }

    // Validate environment variables
    precondition ($account_id != null && $account_id != "") {
      error_type = "standard"
      error = "DOCUSIGN_ACCOUNT_ID environment variable not configured"
    }

    precondition ($access_token != null && $access_token != "") {
      error_type = "standard"
      error = "DOCUSIGN_ACCESS_TOKEN environment variable not configured"
    }

    // Validate required inputs
    precondition ($input.subject != null && $input.subject != "") {
      error_type = "inputerror"
      error = "Subject is required"
    }

    precondition ($input.signer_name != null && $input.signer_name != "") {
      error_type = "inputerror"
      error = "Signer name is required"
    }

    precondition ($input.signer_email != null && $input.signer_email != "") {
      error_type = "inputerror"
      error = "Signer email is required"
    }

    precondition ($input.document_base64 != null && $input.document_base64 != "") {
      error_type = "inputerror"
      error = "Document base64 content is required"
    }

    // Generate document ID
    var $document_id { value = "1" }

    // Build the envelope definition
    var $envelope_payload {
      value = {
        emailSubject: $input.subject,
        documents: [
          {
            documentId: $document_id,
            name: $input.document_name,
            fileExtension: $input.document_file_extension,
            documentBase64: $input.document_base64
          }
        ],
        recipients: {
          signers: [
            {
              email: $input.signer_email,
              name: $input.signer_name,
              recipientId: "1",
              routingOrder: "1",
              tabs: {
                signHereTabs: [
                  {
                    documentId: $document_id,
                    pageNumber: "1",
                    xPosition: "100",
                    yPosition: "150"
                  }
                ],
                dateSignedTabs: [
                  {
                    documentId: $document_id,
                    pageNumber: "1",
                    xPosition: "100",
                    yPosition: "200"
                  }
                ]
              }
            }
          ]
        },
        status: "sent"
      }
    }

    // Build the API URL
    var $api_url {
      value = "https://demo.docusign.net/restapi/v2.1/accounts/" ~ $account_id ~ "/envelopes"
    }

    // Send the request to DocuSign
    api.request {
      url = $api_url
      method = "POST"
      params = $envelope_payload
      headers = [
        "Content-Type: application/json",
        "Authorization: Bearer " ~ $access_token
      ]
      timeout = 60
    } as $api_result

    // Initialize response variables
    var $success { value = false }
    var $envelope_id { value = null }
    var $status { value = null }
    var $error_message { value = null }
    var $envelope_uri { value = null }

    // Parse response based on status
    conditional {
      if ($api_result.response.status >= 200 && $api_result.response.status < 300) {
        var $response_body { value = $api_result.response.result }
        var $success { value = true }
        var $envelope_id { value = $response_body|get:"envelopeId" }
        var $status { value = $response_body|get:"status" }
        var $envelope_uri { value = $response_body|get:"uri" }
      }
      else {
        var $success { value = false }
        conditional {
          if ($api_result.response.result != null) {
            var $error_body { value = $api_result.response.result }
            var $error_message {
              value = $error_body|get:"errorCode"
            }
            conditional {
              if ($error_message == null || $error_message == "") {
                var $error_message {
                  value = $error_body|get:"message"
                }
              }
            }
          }
          else {
            var $error_message {
              value = "DocuSign API error: HTTP " ~ ($api_result.response.status|to_text)
            }
          }
        }
      }
    }
  }

  response = {
    success: $success,
    envelope_id: $envelope_id,
    status: $status,
    envelope_uri: $envelope_uri,
    error: $error_message
  }
}
