require 'spec_helper'

describe SimpleSolr::Search do
  describe SimpleDocument do
    it "responds to search" do
      SimpleDocument.should respond_to(:simple_search)
    end
    
    it "gets results" do
      SimpleDocument.should_receive(:get).with("http://test.local:8983/solr/select", :query => {:q => 'bonanza'})
      SimpleDocument.simple_search 'bonanza'
    end
  end
end
