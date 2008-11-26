#
# =>    comments.rb
# =>    Copyright (c) 2008 Daniel Bogan. http://waferbaby.com/
#

class Comments < Application
	def index
		@comments = Comment.all
		display @comments
	end

	def show
		@comment = Comment.get(params[:id])
		raise NotFound unless @comment
		display @comment
	end

	def new
		only_provides :html
		
		@comment = Comment.new
		@post = Post.first(:slug => params[:slug])
		
		render
	end

	def edit
		only_provides :html
		@comment = Comment.get(params[:id])
		raise NotFound unless @comment
		render
	end

	def create
		@post = Post.first(:slug => params[:slug])
		
		@comment = Comment.new(params[:comment])
		@comment.person = current_person
		
		@post.comments << @comment
		
		if @comment.valid? && @post.save
			redirect resource(@post) + "/#from-#{@comment.person.username}-at-#{@comment.created_time}"
		else
			render :new
		end
	end

	def update
		@comment = Comment.get(params[:id])
		raise NotFound unless @comment
		if @comment.update_attributes(params[:comment]) || !@comment.dirty?
			redirect resource(:comments)
		else
			raise BadRequest
		end
	end

	def destroy
		@comment = Comment.get(params[:id])
		raise NotFound unless @comment
		if @comment.destroy
			redirect resource(:comments)
		else
			raise BadRequest
		end
	end
end