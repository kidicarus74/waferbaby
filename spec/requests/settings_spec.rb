require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a setting exists" do
  Setting.all.destroy!
  request(resource(:settings), :method => "POST", 
    :params => { :setting => { :id => nil }})
end

describe "resource(:settings)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:settings))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of settings" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a setting exists" do
    before(:each) do
      @response = request(resource(:settings))
    end
    
    it "has a list of settings" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Setting.all.destroy!
      @response = request(resource(:settings), :method => "POST", 
        :params => { :setting => { :id => nil }})
    end
    
    it "redirects to resource(:settings)" do
      @response.should redirect_to(resource(Setting.first), :message => {:notice => "setting was successfully created"})
    end
    
  end
end

describe "resource(@setting)" do 
  describe "a successful DELETE", :given => "a setting exists" do
     before(:each) do
       @response = request(resource(Setting.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:settings))
     end

   end
end

describe "resource(:settings, :new)" do
  before(:each) do
    @response = request(resource(:settings, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@setting, :edit)", :given => "a setting exists" do
  before(:each) do
    @response = request(resource(Setting.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@setting)", :given => "a setting exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Setting.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @setting = Setting.first
      @response = request(resource(@setting), :method => "PUT", 
        :params => { :setting => {:id => @setting.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@setting))
    end
  end
  
end

