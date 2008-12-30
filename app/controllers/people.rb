#
# =>    people.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

class People < Application
	before :login_required, :only => [:edit, :delete, :update, :destroy]
	provides :atom, :text, :xml

	def index
		@count, @people = Person.paginated(:order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => PAGE_SIZE)
		display @people
	end

	def index_by_letter_or_number(character)
		@count, @people = Person.paginated(:username.like => "#{character}%", :order => [:username.asc], :page => params[:page] ? params[:page].to_i : 1, :per_page => PAGE_SIZE)
		display @people, :index
	end

	def index_by_date(created_year, created_month = nil, created_day = nil)
		created_month = '__' if created_month == nil
		created_day   = '__' if created_day   == nil

		date = "#{created_year}-#{created_month}-#{created_day}%"
		@count, @people = Person.paginated(:created_at.like => date, :order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => PAGE_SIZE)

		display @people, :index
	end

	def show(username)
		@person = Person.first(:username => username)
		raise NotFound unless @person
		display @person
	end

	def new
		only_provides :html
		@person = Person.new

		render
	end

	def edit(username)
		only_provides :html
		
		@person = Person.first(:username => username)
		raise NotFound unless @person && @person == current_person
		
		render
	end

	def create(person)
		@person = Person.new(person)
		if @person.save
			session[:message] = "Hell yeah! Welcome aboard."
			
			self.current_person = Person.authenticate(person[:username], person[:password])
			redirect resource(@person)
		else
			render :new
		end
	end
	
	def update(username, person)
		@person = Person.first(:username => username)
		raise NotFound unless @person && @person == current_person

		if @person.update_attributes(person, :display_name, :email_address, :profile)
			redirect resource(@person)
		else
			display @person, :edit
		end		
	end

	def destroy(username)
		@person = Person.first(:username => username)
		raise NotFound unless @person && @person == current_person
		if @person.destroy
			redirect resource(:people)
		else
			raise InternalServerError
		end
	end
end