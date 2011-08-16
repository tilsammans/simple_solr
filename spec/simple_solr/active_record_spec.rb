require 'spec_helper'

describe SimpleSolr::ActiveRecord do
  describe SimpleDocument do
    it "provides simple_solr class method" do
      SimpleDocument.should respond_to(:simple_solr)
    end

    it "posts to solr after save" do
      SimpleDocument.should_receive(:post).with("test.local:8983/solr", :body => "<add><doc><field name=\"title\">Omg Ponies</field></doc></add>")
      document = SimpleDocument.new :title => 'Omg Ponies'
      document.save
    end
  end
end
