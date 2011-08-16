module SimpleSolr
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def simple_solr
        class_eval do
          # httparty
          include HTTParty
          headers 'Content-Type' => "application/json"
          
          # callbacks
          after_save :update_simple_solr
        end
        
        include InstanceMethods
      end
    end
    
    module InstanceMethods
      def update_simple_solr
        self.class.post(SimpleSolr.configuration.master_uri, :body => to_solr)
      end
      
      private
        def to_solr
          xml = Builder::XmlMarkup.new
          
          xml.add do
            xml.doc do
              xml.field "Omg Ponies", :name => "title"
            end
          end
        end
    end
  end
end