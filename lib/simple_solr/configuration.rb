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
    # Define methods for the <code>solr</code> key. This key is normally used to
    # configure SimpleSolr. 
    %w(hostname port path).each do |method|
      define_method method do
        configuration('solr', method) || self.send("default_#{method}")
      end
    end

    # Define methods for the <code>master_solr</code> key. When present, this key
    # defines the Solr used for all write operations, while all read operations
    # take place on the Solr defined in the <code>solr</code> key.
    %w(hostname port path).each do |method|
      define_method "master_#{method}" do
        configuration('master_solr', method) || self.send(method)
      end
    end
    
    # Full URI to use for all read operations.
    def uri
      "#{hostname}:#{port}#{path}"
    end
    
    # Full URI to use for all write operations.
    # Automatically falls back to the <code>uri</code> when no master defined.
    def master_uri
      "#{master_hostname}:#{master_port}#{master_path}"
    end
    
    private
      def configuration(*keys)
        keys.inject(user_configuration) do |hash, key|
          hash[key] if hash
        end
      end
      
      def user_configuration
        @user_configuration ||=
          begin
            path = File.join(::Rails.root, 'config', config_file_name)
            if File.exist?(path)
              File.open(path) do |file|
                YAML.load(file)[::Rails.env]
              end
            else
              {}
            end
          end
      end
      
      def default_hostname
        'localhost'
      end
      
      def default_port
        8983
      end
      
      def default_path
        "/solr"
      end
      
      def config_file_name
        'simple_solr.yml'
      end
  end
end