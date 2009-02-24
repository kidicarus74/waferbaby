require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a interview exists" do
  Interview.all.destroy!
  request(resource(:interviews), :method => "POST", 
    :params => { :interview => { :id => nil }})
end

describe "resource(:interviews)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:interviews))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of interviews" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a interview exists" do
    before(:each) do
      @response = request(resource(:interviews))
    end
    
    it "has a list of interviews" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Interview.all.destroy!
      @response = request(resource(:interviews), :method => "POST", 
        :params => { :interview => { :id => nil }})
    end
    
    it "redirects to resource(:interviews)" do
      @response.should redirect_to(resource(Interview.first), :message => {:notice => "interview was successfully created"})
    end
    
  end
end

describe "resource(@interview)" do 
  describe "a successful DELETE", :given => "a interview exists" do
     before(:each) do
       @response = request(resource(Interview.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:interviews))
     end

   end
end

describe "resource(:interviews, :new)" do
  before(:each) do
    @response = request(resource(:interviews, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@interview, :edit)", :given => "a interview exists" do
  before(:each) do
    @response = request(resource(Interview.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@interview)", :given => "a interview exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Interview.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @interview = Interview.first
      @response = request(resource(@interview), :method => "PUT", 
        :params => { :interview => {:id => @interview.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@interview))
    end
  end
  
end

