#
#	brainstorms.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Brainstorms < Application
	before :admin_required, :only => [:new, :edit, :delete, :update, :destroy]
	provides :atom, :text, :xml

	def index
		@count, @brainstorms = Brainstorm.paginated(:order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => 10)
		display @brainstorms
	end

        def index_by_date(created_year, created_month = nil, created_day = nil)
                created_month = '__' if created_month == nil
                created_day   = '__' if created_day   == nil
                
                date = "#{created_year}-#{created_month}-#{created_day}%"
                @count, @brainstorms = Brainstorm.paginated(:created_at.like => date, :order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => 10)
                
                display @brainstorms, :index
        end

	def show(slug)
                @brainstorm = Brainstorm.first(:slug => slug)
                raise NotFound unless @brainstorm

		# Not super happy with this, but it works for now.
		
		@count, @brainstorm.answers = @brainstorm.answers.all.paginated(:page => params[:page] ? params[:page].to_i : 1, :per_page => 10)

                render :show
        end

	def new
		only_provides :html
		@brainstorm = Brainstorm.new
		display @brainstorm
	end

	def edit(slug)
		only_provides :html
		@brainstorm = Brainstorm.first(:slug => slug)
		raise NotFound unless @brainstorm
		display @brainstorm
	end

	def create(brainstorm)
		@brainstorm = Brainstorm.new(brainstorm)
		if @brainstorm.save
			redirect resource(@brainstorm)
		else
			session[:message] = "Brainstorm failed to be created"
			render :new
		end
	end

	def update(slug, brainstorm)
		@brainstorm = Brainstorm.first(:slug => slug)
		raise NotFound unless @brainstorm
		if @brainstorm.update_attributes(brainstorm)
			redirect resource(@brainstorm)
		else
			display @brainstorm, :edit
		end
	end

	def destroy(slug)
		@brainstorm = Brainstorm.first(:slug => slug)
		raise NotFound unless @brainstorm
		if @brainstorm.destroy
			redirect resource(:brainstorms)
		else
			raise InternalServerError
		end
	end

end