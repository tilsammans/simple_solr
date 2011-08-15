require 'spec_helper'

describe SimpleSolr::ActiveRecord do
  it "provides simple_solr class method" do
    SimpleDocument.simple_solr
  end
  
  it "posts to solr after save" do
    HTTParty.should_receive(:post).with("http://example.com/solr/update", :body => title_body)
    document = SimpleDocument.new :title => 'Omg Ponies'
    document.save
  end
end
