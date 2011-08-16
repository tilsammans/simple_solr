module SimpleSolr
  module Search
    # Search using the given query. Additional parameters can be added as a hash.
    # For instance, to limit the results by using an +fq+ parameter:
    #
    #   Product.simple_search 'delicious', :fq => "category:fruit"
    def simple_search(query, params={})
      query = {:q => query}
      get(SimpleSolr.configuration.uri + "/select", :query => query.merge(params))
    end
  end
end