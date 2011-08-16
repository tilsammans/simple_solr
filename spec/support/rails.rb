require 'pathname'

# Fake Rails class to provide stubbed methods we use on the real one.
class Rails
  def self.env
    'test'
  end
  
  def self.root
    Pathname.new File.dirname(__FILE__) + "/.."
  end
end
