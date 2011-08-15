ActiveRecord::Schema.define(:version => 0) do
  create_table :simple_documents, :force => true do |t|
    t.string :title
  end
end