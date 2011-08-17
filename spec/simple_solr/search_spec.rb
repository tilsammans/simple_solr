require 'spec_helper'

describe SimpleSolr::Search do
  let(:httparty) { stub("httparty", :parsed_response => {})}
  
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
  end
end
