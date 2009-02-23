#
#	answers.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Answers < Application
	before :login_required, :only => [:new, :edit, :delete, :create, :update, :destroy]
	
	def index
		@count, @answers = Answer.paginated(:order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => PAGE_SIZE)
		display @answers
	end

	def show(id)
		@answer = Answer.get(id)
		raise NotFound unless @answer
		
		display @answer
	end

	def new(slug)
		only_provides :html
		
		@answer = Answer.new
		@brainstorm = Brainstorm.first(:slug => slug)
		
		render
	end

	def edit(id)
		only_provides :html
		
		@answer = Answer.get(id)
		raise NotFound unless @answer && this_is_mine(@answer)
		
		render
	end

	def create(slug, answer)
		@brainstorm = Brainstorm.first(:slug => slug)
		
		@answer = Answer.new(answer)
		@answer.person = current_person
		
		@brainstorm.answers << @answer
		
		if @answer.valid? && @brainstorm.save
			redirect resource(@brainstorm) + "/#answer-at-#{@answer.created_time}"
		else
			render :new
		end
	end

	def update(id, answer)
		@answer = Answer.get(id)
		raise NotFound unless @answer && this_is_mine(@answer)
		if @answer.update_attributes(answer)
			redirect resource(:answers)
		else
			display @answer, :edit
		end
	end

	def destroy(id)
		@answer = Answer.get(id)
		
		raise NotFound unless @answer && this_is_mine(@answer)
		if @answer.destroy
			redirect resource(:answers)
		else
			raise InternalServerError
		end
	end
end