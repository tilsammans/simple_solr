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
        
        # Store the simple_solr fields for this class
        cattr_accessor :simple_solr_fields
        self.simple_solr_fields = {}
        block.call
        
        include InstanceMethods
      end
      
      # gets called by every +field+ line inside the simple_solr block.
      # It stores the given values in +simple_solr_fields+, which we later use to build the XML.
      def field(name, value=nil)
        simple_solr_fields[name] = value
      end
    end
    
    module InstanceMethods
      # callback which uses httparty to send a POST to solr.
      def update_simple_solr
        if SimpleSolr.configuration.present?
          self.class.post(SimpleSolr.configuration.master_uri, :body => to_solr)
        end
      end
      
      private
        # Convert this instance's attributes to an XML suitable for Solr.
        # The fields in the XML are determined from the simple_solr block.
        def to_solr
          xml = Builder::XmlMarkup.new
          
          xml.add do
            xml.doc do
              self.class.simple_solr_fields.each do |name, value|
                if value.nil?
                  # no value given, get it from the attribute
                  xml.field self.send(name), :name => name
                elsif value.is_a?(Symbol)
                  # symbol given, use it to get the attribute
                  xml.field self.send(value), :name => name
                else
                  # value given, use it directly.
                  xml.field value, :name => name
                end
              end
            end
          end
        end
    end
  end
end