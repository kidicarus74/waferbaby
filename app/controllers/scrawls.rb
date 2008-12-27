#
# =>    scrawls.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

class Scrawls < Application
	before :login_required, :only => [:new, :edit, :delete, :create, :update, :destroy]
	provides :atom, :text, :xml

	def index
		@count, @scrawls = Scrawl.paginated(:order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => PAGE_SIZE)
		display @scrawls
	end

	def index_by_date(created_year, created_month = nil, created_day = nil)
		created_month = '__' if created_month == nil
		created_day   = '__' if created_day   == nil

		date = "#{created_year}-#{created_month}-#{created_day}%"
		@count, @scrawls = Scrawl.paginated(:created_at.like => date, :order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => PAGE_SIZE)

		display @scrawls, :index
	end

	def show(id)
		@scrawl = Scrawl.get(id)
		raise NotFound unless @scrawl
		display @scrawl
	end

	def new
		only_provides :html
		@scrawl = Scrawl.new
		render
	end

	def edit(id)
		only_provides :html

		@scrawl = Scrawl.first(:id => id, :person_id => current_person.id)
		raise NotFound unless @scrawl

		render
	end

	def delete(id)
		only_provides :html

		@scrawl = Scrawl.firs(:id => id, :person_id => current_person.id)		
		raise NotFound unless @scrawl

		render
	end

	def create(scrawl)
		@scrawl = Scrawl.new(scrawl)
		@scrawl.person = current_person

		if @scrawl.save
			redirect resource(:scrawls)
		else
			render :new
		end
	end

	def update(id, scrawl)
		@scrawl = Scrawl.get(id)
		raise NotFound unless @scrawl && this_is_mine(@scrawl)

		if @scrawl.update_attributes(scrawl)
			redirect resource(@scrawl)
		else
			display @scrawl, :edit
		end
	end

	def destroy(id)
		@scrawl = Scrawl.get(id)
		raise NotFound unless @scrawl && this_is_mine(@scrawl)

		if @scrawl.destroy
			redirect resource(:scrawls)
		else
			raise InternalServerError
		end
	end
end