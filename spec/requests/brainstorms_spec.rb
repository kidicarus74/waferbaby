require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a brainstorm exists" do
  Brainstorm.all.destroy!
  request(resource(:brainstorms), :method => "POST", 
    :params => { :brainstorm => { :id => nil }})
end

describe "resource(:brainstorms)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:brainstorms))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of brainstorms" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a brainstorm exists" do
    before(:each) do
      @response = request(resource(:brainstorms))
    end
    
    it "has a list of brainstorms" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Brainstorm.all.destroy!
      @response = request(resource(:brainstorms), :method => "POST", 
        :params => { :brainstorm => { :id => nil }})
    end
    
    it "redirects to resource(:brainstorms)" do
      @response.should redirect_to(resource(Brainstorm.first), :message => {:notice => "brainstorm was successfully created"})
    end
    
  end
end

describe "resource(@brainstorm)" do 
  describe "a successful DELETE", :given => "a brainstorm exists" do
     before(:each) do
       @response = request(resource(Brainstorm.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:brainstorms))
     end

   end
end

describe "resource(:brainstorms, :new)" do
  before(:each) do
    @response = request(resource(:brainstorms, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@brainstorm, :edit)", :given => "a brainstorm exists" do
  before(:each) do
    @response = request(resource(Brainstorm.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@brainstorm)", :given => "a brainstorm exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Brainstorm.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @brainstorm = Brainstorm.first
      @response = request(resource(@brainstorm), :method => "PUT", 
        :params => { :brainstorm => {:id => @brainstorm.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@brainstorm))
    end
  end
  
end

