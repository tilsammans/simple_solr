require 'spec_helper'

describe SimpleSolr::Configuration do
  it { should be_present}
  
  its(:hostname)          { should eq('test.local')}
  its(:port)              { should eq(8983)}
  its(:path)              { should eq('/solr')}
  its(:uri)               { should eq('http://test.local:8983/solr')}

  its(:master_hostname)   { should eq('test.local')}
  its(:master_port)       { should eq(8983)}
  its(:master_path)       { should eq('/solr')}
  its(:master_uri)        { should eq('http://test.local:8983/solr')}
  
  context "unconfigured Rails env" do
    before do
      ::Rails.stub(:env).and_return('staging')
    end
    
    it { should_not be_present }
  end

  context "missing config file" do
    before do
      ::Rails.stub(:root).and_return(Pathname.new('/'))
    end
    
    its(:hostname)        { should eq('localhost')}
    its(:port)            { should eq(8983)}
    its(:path)            { should eq('/solr')}
    its(:uri)             { should eq('http://localhost:8983/solr')}

    its(:master_hostname) { should eq('localhost')}
    its(:master_port)     { should eq(8983)}
    its(:master_path)     { should eq('/solr')}
    its(:master_uri)      { should eq('http://localhost:8983/solr')}
  end

  context "master/slave configuration" do
    before do
      subject.stub(:config_file_name).and_return('master_slave.yml')
    end
    
    its(:hostname)        { should eq('slave.local')}
    its(:port)            { should eq(9000)}
    its(:path)            { should eq('/public')}
    its(:uri)             { should eq('http://slave.local:9000/public')}

    its(:master_hostname) { should eq('master.local')}
    its(:master_port)     { should eq(9000)}
    its(:master_path)     { should eq('/public')}
    its(:master_uri)      { should eq('http://master.local:9000/public')}
  end
end
