module SimpleSolr
  module Search
    def simple_search(query)
      get(SimpleSolr.configuration.uri + "/select", :query => {:q => query})
    end
  end
end