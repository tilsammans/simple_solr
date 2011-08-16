module SimpleSolr
  # SimpleSolr is configured via the config/simple_solr.yml file, which
  # contains properties keyed by environment name.
  #
  #   production:
  #     solr:
  #       hostname: "solr.slave.local"
  #       port: 8983
  #       path: "/solr"
  #     master_solr:
  #       hostname: "solr.master.local"
  #       port: 8983
  #       path: "/solr"
  #
  # If the <code>master_solr</code> configuration is present, SimpleSolr will use
  # the Solr instance specified there for all write operations, and the Solr
  # configured under <code>solr</code> for all read operations.
  class Configuration
    def hostname
      @hostname ||= user_configuration_from_key('solr', 'hostname') || default_hostname
    end
    
    def port
      @port ||= user_configuration_from_key('solr', 'port') || default_port
    end
    
    def path
      @path ||= user_configuration_from_key('solr', 'path') || default_path
    end
    
    def master_hostname
      @master_hostname ||= user_configuration_from_key('master_solr', 'hostname') || hostname
    end
    
    def master_port
      @master_port ||= user_configuration_from_key('master_solr', 'port') || port
    end
    
    def master_path
      @master_path ||= user_configuration_from_key('master_solr', 'path') || path
    end
    
    private
      def default_hostname
        'localhost'
      end
      
      def default_port
        8983
      end
      
      def default_path
        "/solr"
      end
  end
end