class Entries < Application

	provides :atom, :text, :xml
	
	def index
		@count, @entries = Entry.all.paginated(:page => params[:page] ? params[:page].to_i : 1, :per_page => 10)
		
		render
	end
	
	def show(username)
		@person = Person.first(:username => username)
		raise NotFound unless @person

		@count, @entries = @person.entries.all.paginated(:page => params[:page] ? params[:page].to_i : 1, :per_page => 10)

		render
	end
  
end
