require 'spec_helper'

describe SimpleSolr::Search do
  describe SimpleDocument do
    it "responds to search" do
      SimpleDocument.should respond_to(:simple_search)
    end
  end
end
