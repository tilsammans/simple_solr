module SimpleSolr
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def simple_solr
        class_eval do
          after_save :update_simple_solr
        end
        
        include InstanceMethods
      end
    end
    
    module InstanceMethods
      def update_simple_solr
        HTTParty.post("http://example.com/solr/update", :body => {:title => "Omg Ponies"})
      end
    end
  end
end