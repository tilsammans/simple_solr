require 'spec_helper'

describe SimpleSolr::ActiveRecord do
  it "provides simple_solr macro" do
    class SimpleDocument < ActiveRecord::Base
      simple_solr do
        # this space intentionally left blank
      end
    end
  end
end
