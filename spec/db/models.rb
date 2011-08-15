# A bunch of models with varying amounts of simple_solrism.

class SimpleDocument < ActiveRecord::Base
  simple_solr do
    string :title
  end
end
