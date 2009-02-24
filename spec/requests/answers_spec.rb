require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a answer exists" do
  Answer.all.destroy!
  request(resource(:answers), :method => "POST", 
    :params => { :answer => { :id => nil }})
end

describe "resource(:answers)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:answers))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of answers" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a answer exists" do
    before(:each) do
      @response = request(resource(:answers))
    end
    
    it "has a list of answers" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Answer.all.destroy!
      @response = request(resource(:answers), :method => "POST", 
        :params => { :answer => { :id => nil }})
    end
    
    it "redirects to resource(:answers)" do
      @response.should redirect_to(resource(Answer.first), :message => {:notice => "answer was successfully created"})
    end
    
  end
end

describe "resource(@answer)" do 
  describe "a successful DELETE", :given => "a answer exists" do
     before(:each) do
       @response = request(resource(Answer.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:answers))
     end

   end
end

describe "resource(:answers, :new)" do
  before(:each) do
    @response = request(resource(:answers, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@answer, :edit)", :given => "a answer exists" do
  before(:each) do
    @response = request(resource(Answer.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@answer)", :given => "a answer exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Answer.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @answer = Answer.first
      @response = request(resource(@answer), :method => "PUT", 
        :params => { :answer => {:id => @answer.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@answer))
    end
  end
  
end

