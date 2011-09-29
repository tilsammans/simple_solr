module SimpleSolr
  module Search
    # Search using the given query. Additional parameters can be added as a hash.
    # For instance, to limit the results by using an +fq+ parameter:
    #
    #   Product.simple_search 'delicious', :fq => "category:fruit"
    #
    # Returns a Nokogiri::XML::Document.
    def simple_search(query, params={})
      query = {:q => query}
      response = get(SimpleSolr.configuration.uri + "/select", :query => query.merge(params))
      Nokogiri::XML(response.body)
    end

    # Returns all +doc+ elements, aka matching documents, from the search results in an array.
    def simple_search_docs(query, params={})
      simple_search(query, params).css('doc')
    end
  end
end