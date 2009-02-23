#
#	interviews.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Interviews < Application
	before :admin_required, :only => [:new, :edit, :delete, :update, :destroy]
	provides :atom, :text, :xml

	def index
		@count, @interviews = Interview.paginated(:order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => 10)
		display @interviews
	end

        def index_by_date(created_year, created_month = nil, created_day = nil)
                created_month = '__' if created_month == nil
                created_day   = '__' if created_day   == nil
                
                date = "#{created_year}-#{created_month}-#{created_day}%"
                @count, @interviews = Interview.paginated(:created_at.like => date, :order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => 10)
                
                display @interviews, :index
        end

	def show(slug)
                @interview = Interview.first(:slug => slug)
                raise NotFound unless @interview
                
                render :show
        end

	def new
		only_provides :html
		@interview = Interview.new
		display @interview
	end

	def edit(slug)
		only_provides :html
		@interview = Interview.first(:slug => slug)
		raise NotFound unless @interview
		display @interview
	end

	def create(interview)
		@interview = Interview.new(interview)
		if @interview.save
			redirect resource(@interview)
		else
			session[:message] = "Interview failed to be created"
			render :new
		end
	end

	def update(slug, interview)
		@interview = Interview.first(:slug => slug)
		raise NotFound unless @interview
		if @interview.update_attributes(interview)
			redirect resource(@interview)
		else
			display @interview, :edit
		end
	end

	def destroy(slug)
		@interview = Interview.first(:slug => slug)
		raise NotFound unless @interview
		if @interview.destroy
			redirect resource(:interviews)
		else
			raise InternalServerError
		end
	end

end