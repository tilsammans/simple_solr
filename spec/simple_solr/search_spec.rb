require 'spec_helper'

fixture = File.dirname(__FILE__) + "/../fixtures/result.xml"

FakeWeb.register_uri(:get,
  "http://test.local:8983/solr/select?q=bonanza",
  :body => File.read(fixture),
  :content_type => "application/xml"
)

describe SimpleSolr::Search do

  describe SimpleDocument do
    
    it "returns a Nokogiri::XML::Document" do
      SimpleDocument.simple_search('bonanza').should be_a(Nokogiri::XML::Document)
    end
    
    it "returns one document" do
      SimpleDocument.simple_search('bonanza').css('doc').length.should eq 1
    end
    
    it "returns one simple search result" do
      SimpleDocument.simple_search_docs('bonanza').length.should eq 1
    end
    
  end

end
