module PipefyApi
  def self.post(values)
    endpoint = ENV['PIPEFY_GRAPHQL_ENDPOINT']
    headers = {
      content_type: 'application/json',
      authorization: "Bearer #{ENV['PIPEFY_TOKEN']}"
    }

    RestClient.post(endpoint, values, headers)
  end
end
