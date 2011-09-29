# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "simple_solr/version"

Gem::Specification.new do |s|
  s.name        = "simple_solr"
  s.version     = SimpleSolr::VERSION
  s.authors     = ["Joost Baaij"]
  s.email       = ["joost@spacebabies.nl"]
  s.homepage    = "https://github.com/tilsammans/simple_solr"
  s.summary     = %q{Simple Solr client}
  s.description = %q{Solr client for Ruby on Rails with as few features as possible.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", ">= 2"
  s.add_development_dependency "fakeweb"
  
  s.add_runtime_dependency "activerecord"
  s.add_runtime_dependency "nokogiri"
  s.add_runtime_dependency "httparty"
  s.add_runtime_dependency "builder"
end
