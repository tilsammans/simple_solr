require 'spec_helper'

fixture = File.dirname(__FILE__) + "/../fixtures/result.xml"

FakeWeb.register_uri(:get,
  "http://test.local:8983/solr/select?q=bonanza",
  :body => File.read(fixture),
  :content_type => "application/xml"
)

describe SimpleSolr::Search do
  let(:response) { stub("response")}
  let(:httparty) { stub("httparty", :parsed_response => {'response' => response})}
  
  describe SimpleDocument do
    it "responds to search" do
      SimpleDocument.should respond_to(:simple_search)
    end
    
    it "gets results" do
      SimpleDocument.should_receive(:get).with("http://test.local:8983/solr/select", :query => {:q => 'bonanza'}).and_return(httparty)
      SimpleDocument.simple_search 'bonanza'
    end

    it "allows parameters" do
      SimpleDocument.should_receive(:get).with("http://test.local:8983/solr/select", :query => {:q => 'bonanza', :fq => "brand_site:www.example.com"}).and_return(httparty)
      SimpleDocument.simple_search 'bonanza', :fq => "brand_site:www.example.com"
    end
    
    it "result is not empty" do
      SimpleDocument.simple_search('bonanza')['result'].should_not be_empty
    end
    
    it "finds str results" do
      str = SimpleDocument.simple_search('bonanza')['result']['doc']['str']
      str[0].should == 'www.zappelin.nl'
      str[0].attributes.should == {"name" => "brand_site"}
    end
  end
end
