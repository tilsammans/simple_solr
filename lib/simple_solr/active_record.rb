module SimpleSolr
  module ActiveRecord
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def simple_solr(&block)
        class_eval do
          # httparty
          include HTTParty
          
          # callbacks
          after_save :update_simple_solr
        end
        
        cattr_accessor :simple_solr_fields
        self.simple_solr_fields = block.call
        
        include InstanceMethods
      end
      
      def field(name, value=nil)
        {name => value}
      end
    end
    
    module InstanceMethods
      def update_simple_solr
        if SimpleSolr.configuration.present?
          self.class.post(SimpleSolr.configuration.master_uri, :body => to_solr)
        end
      end
      
      private
        def to_solr
          xml = Builder::XmlMarkup.new
          
          xml.add do
            xml.doc do
              self.class.simple_solr_fields.each do |name, value|
                if value.nil?
                  xml.field self.send(name), :name => name
                else
                  xml.field value, :name => name
                end
              end
            end
          end
        end
    end
  end
end