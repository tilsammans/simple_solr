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
    # To dig deeper, use css selectors to find the elements you need.
    #
    #   <doc><str name="title">Woezel en Pip</str></doc>
    #
    # the contents of the title tag can be fetched like this:
    #
    #   results = Document.simple_search_docs('apple')
    #   results.first.at_css('str[name=title]').contents   # => Woezel en Pip
    #
    # I told you it was close to the metal! Refer to the Nokogiro docs for more information.
    def simple_search_docs(query, params={})
      simple_search(query, params).css('doc')
    end
  end
end