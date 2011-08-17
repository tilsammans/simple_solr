require 'spec_helper'

describe SimpleSolr::Search do
  let(:response) { stub("response")}
  let(:httparty) { stub("httparty", :parsed_response => {'response' => response})}
  
  describe SimpleDocument do
    before do
      SimpleDocument.stub(:get).and_return(httparty)
    end
    
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
    
    it "returns parsed response" do
      SimpleDocument.simple_search('bonanza').should eq(response)
    end
  end
end
