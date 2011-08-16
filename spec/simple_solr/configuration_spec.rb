require 'spec_helper'

describe SimpleSolr::Configuration do
  its(:hostname)          { should eq('test.local')}
  its(:port)              { should eq(8983)}
  its(:path)              { should eq('/solr')}
  its(:uri)               { should eq('test.local:8983/solr')}

  its(:master_hostname)   { should eq('test.local')}
  its(:master_port)       { should eq(8983)}
  its(:master_path)       { should eq('/solr')}
  its(:master_uri)        { should eq('test.local:8983/solr')}

  context "missing config file" do
    before do
      ::Rails.stub(:root).and_return(Pathname.new('/'))
    end
    
    its(:hostname)        { should eq('localhost')}
    its(:port)            { should eq(8983)}
    its(:path)            { should eq('/solr')}
    its(:uri)             { should eq('localhost:8983/solr')}

    its(:master_hostname) { should eq('localhost')}
    its(:master_port)     { should eq(8983)}
    its(:master_path)     { should eq('/solr')}
    its(:master_uri)      { should eq('localhost:8983/solr')}
  end

  context "master/slave configuration" do
    before do
      subject.stub(:config_file_name).and_return('master_slave.yml')
    end
    
    its(:hostname)        { should eq('slave.local')}
    its(:port)            { should eq(8983)}
    its(:path)            { should eq('/solr')}
    its(:uri)             { should eq('slave.local:8983/solr')}

    its(:master_hostname) { should eq('master.local')}
    its(:master_port)     { should eq(8983)}
    its(:master_path)     { should eq('/solr')}
    its(:master_uri)      { should eq('master.local:8983/solr')}
  end
end
