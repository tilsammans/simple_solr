module SimpleSolr
  module Update
    def self.included(base)
      base.extend ClassMethods
    end
    
    module ClassMethods
      def simple_solr
        class_eval do
          # httparty
          include HTTParty
          headers 'Content-Type' => 'text/xml'
          
          # callbacks
          after_save :add_to_solr
          after_destroy :delete_from_solr
        end
        
        # Store the simple_solr fields for this class
        cattr_accessor :simple_solr_fields
        self.simple_solr_fields = { :id => nil }
        
        yield if block_given?
        
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
      def add_to_solr
        if SimpleSolr.configuration.present?
          self.class.post(SimpleSolr.configuration.master_uri + "/update?commit=true", :body => to_solr)
        end
      end
      
      def delete_from_solr
        if SimpleSolr.configuration.present?
          self.class.post(SimpleSolr.configuration.master_uri + "/update?commit=true", :body => to_solr_delete)
        end
      end
      
      private
        def to_solr_delete
          xml = Builder::XmlMarkup.new
          
          xml.delete do
            xml.id id
          end
        end
        
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
                elsif value.is_a?(Proc)
                  # Procs are used to fetch information from the instance
                  xml.field value.call(self), :name => name
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