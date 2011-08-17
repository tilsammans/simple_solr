module SimpleSolr
  module Search
    # Search using the given query. Additional parameters can be added as a hash.
    # For instance, to limit the results by using an +fq+ parameter:
    #
    #   Product.simple_search 'delicious', :fq => "category:fruit"
    #
    # Returns a hash with the search results:
    #
    # {
    #   "lst" => [{"int"=>["0", "18"], "name"=>"responseHeader"},{"name"=>"highlighting"}],
    #   "result" => {"name"=>"response", "numFound"=>"0", "start"=>"0", "maxScore"=>"0.0"}
    # }
    def simple_search(query, params={})
      query = {:q => query}
      get(SimpleSolr.configuration.uri + "/select", :query => query.merge(params)).parsed_response['response']
    end
  end
end