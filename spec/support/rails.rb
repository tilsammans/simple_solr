require 'pathname'

class Rails
  def self.env
    'test'
  end
  
  def self.root
    Pathname.new File.dirname(__FILE__) + "/.."
  end
end
