require 'spec_helper'

# you reading this! yes you!
# the database ids are hardcoded in this spec. 1, 2 and so on.
# i KNOW that's brittle as fuck. But it also Just Works.
# so a nice TODO would be to implement that properly.
# we kinda need the ID value to spec all the way though...

describe SimpleSolr::Update do
  before do
    SparseDocument.stub(:post) # prevent calls going out over the wire
  end

  describe SparseDocument do
    it "stores just the id field" do
      SparseDocument.simple_solr_fields.should eq({:id => nil})
    end
  end
  
  describe SimpleDocument do
    before do
      SimpleDocument.stub(:post) # prevent calls going out over the wire
    end

    it "provides simple_solr class method" do
      SimpleDocument.should respond_to(:simple_solr)
    end
    
    it "stores simple_solr fields" do
      SimpleDocument.simple_solr_fields.should eq({:id => nil, :title => nil})
    end
    
    context "save" do
      it "posts to solr" do
        SimpleDocument.should_receive(:post).with("http://test.local:8983/solr/update?commit=true", :body => "<add><doc><field name=\"id\">1</field><field name=\"title\">Omg Ponies</field></doc></add>")
        SimpleDocument.create! :title => 'Omg Ponies'
      end
    end
    
    context "destroy" do
      it "posts to solr" do
        SimpleDocument.should_receive(:post).with("http://test.local:8983/solr/update?commit=true", :body => "<add><doc><field name=\"id\">2</field><field name=\"title\">Omg Ponies</field></doc></add>")
        SimpleDocument.should_receive(:post).with("http://test.local:8983/solr/update?commit=true", :body => "<delete><id>2</id></delete>")
        document = SimpleDocument.create! :title => 'Omg Ponies'
        document.destroy
      end
    end

    context "when unconfigured" do
      before do
        SimpleSolr.stub_chain(:configuration, :present?).and_return(false)
      end

      it "does nothing" do
        SimpleDocument.should_not_receive(:post)
        document = SimpleDocument.new :title => 'Omg Ponies'
        document.save
      end
    end    
  end
  
  describe FullDocument do
    before do
      FullDocument.stub(:post) # prevent calls going out over the wire
    end
    
    it "posts to solr after save" do
      FullDocument.should_receive(:post).with("http://test.local:8983/solr/update?commit=true", :body => "<add><doc><field name=\"id\">full-document-1</field><field name=\"title\">Rainbows</field><field name=\"date_creation\">2011-08-18 13:32:00 UTC</field><field name=\"shared\">false</field><field name=\"body\"></field></doc></add>")
      FullDocument.create! :title => "Rainbows", :created_at => '2011-08-18 13:32:00'.to_time
    end
  end
end
