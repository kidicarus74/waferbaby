#
# =>    people.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

class People < Application
        # provides :xml, :yaml, :js

        def index
                @people = Person.all(:order => [:created_at.desc], :limit => 20)
                display @people
        end

	def index_by_letter_or_number(character)
		@people = Person.all(:username.like => "#{character}%", :order => [:username.asc])
		
		display @people, :index
	end
	
	def index_by_date(created_year, created_month = nil, created_day = nil)
                created_month = '__' if created_month == nil
                created_day   = '__' if created_day   == nil
                
                date    = "#{created_year}-#{created_month}-#{created_day}%"
                @people  = Person.all(:created_at.like => date, :order => [:created_at.desc])
                
                display @people, :index
        end

        def show
                @person = Person.first(:username => params[:username])
                raise NotFound unless @person
                display @person
        end

        def new
                only_provides :html
                @person = Person.new
                
                render
        end

        def create
                @person = Person.new(params[:person])
                if @person.save
			session[:message] = "Hell yeah! Welcome aboard."
                        redirect resource(@person)
                else
                        render :new
                end
        end

        def destroy
                @person = Person.get(params[:username])
                raise NotFound unless this_is_me(@person)
                if @person.destroy
                        redirect resource(:people)
                else
                        raise BadRequest
                end
        end
        
end