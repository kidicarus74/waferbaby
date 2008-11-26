#
# =>    people.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

class People < Application
        # provides :xml, :yaml, :js

        def index
                @people = Person.all(:order => [:created_at.desc])
                display @people
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