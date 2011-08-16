require 'active_record'
require 'httparty'
require 'builder'

require "simple_solr/active_record"
require "simple_solr/configuration"
require "simple_solr/version"

if defined?(ActiveRecord::Base)
  ActiveRecord::Base.send :include, SimpleSolr::ActiveRecord
end

module SimpleSolr
  class << self
    def configuration
      @configuration ||= SimpleSolr::Configuration.new
    end
  end
end