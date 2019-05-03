module PipefyApi
  def self.post(values)
    endpoint = ENV['PIPEFY_GRAPHQL_ENDPOINT']
    headers = {
      content_type: 'application/json',
      authorization: "Bearer #{ENV['PIPEFY_TOKEN']}"
    }

    # Since RestClient may raise an exception, prepare some debug data beforehand
    Raven.capture_message("Error interacting with Pipefy API", :extra => {'request_body'=> values.to_json})

    response = RestClient.post(endpoint, values, headers)

    if response.code != 200 && response.code != 201
      # Some error may have ocurred; report this to Sentry now
      Raven.capture_message("Error interacting with Pipefy API", :extra => {'request_body'=> values.to_json, 'response_code' => response.code, 'response' => response.to_json})
    end

    # Clear the Raven context now, so future errors won't be reported with this data
    Raven::Context.clear!

    return response

  end
end
