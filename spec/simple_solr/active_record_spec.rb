require 'spec_helper'

describe SimpleSolr::ActiveRecord do
  it "provides simple_solr class method" do
    SimpleDocument.simple_solr
  end
  
  it "posts to solr after save" do
    SimpleDocument.should_receive(:post).with("http://example.com/solr/update", :body => "{\"title\":\"Omg Ponies\"}")
    document = SimpleDocument.new :title => 'Omg Ponies'
    document.save
  end
  
  it "posts" do
    document = SimpleDocument.new :title => 'Omg Ponies'
    document.save
  end
end
