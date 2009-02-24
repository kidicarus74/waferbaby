require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

describe "/entries" do
  before(:each) do
    @response = request("/entries")
  end
end