require 'spec_helper'

describe SimpleSolr::ActiveRecord do
  it "provides simple_solr class method" do
    SimpleDocument.simple_solr
  end
end
