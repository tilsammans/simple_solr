require 'active_record'
require 'httparty'

require "simple_solr/active_record"
require "simple_solr/configuration"
require "simple_solr/version"

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, SimpleSolr::ActiveRecord
end