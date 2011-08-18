# Create schema and load the models
ActiveRecord::Base.establish_connection({:adapter => "sqlite3", :database => ":memory:"})

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false

  load(File.dirname(__FILE__) + '/../db/schema.rb')
  load(File.dirname(__FILE__) + '/../db/models.rb')
end