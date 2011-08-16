# A bunch of models with varying amounts of simple_solrism.

class SimpleDocument < ActiveRecord::Base
  simple_solr do
    field :title
  end
end

class FullDocument < ActiveRecord::Base
  simple_solr do
    field :id,            lambda { "full-document-#{id}" }
    field :title
    field :date_creation, :created_at
    field :shared,        false
    field :body
  end
end