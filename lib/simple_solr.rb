require 'active_record'
require 'httparty'
require 'builder'

require "simple_solr/update"
require "simple_solr/search"
require "simple_solr/configuration"
require "simple_solr/version"

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, SimpleSolr::Update
  ActiveRecord::Base.extend SimpleSolr::Search
end

module SimpleSolr
  class << self
    def configuration
      @configuration ||= SimpleSolr::Configuration.new
    end
  end
end