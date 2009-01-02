#
#	comments.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

class Comments < Application
	before :login_required, :only => [:new, :edit, :delete, :create, :update, :destroy]
	
	def index
		@comments = Comment.all
		display @comments
	end

	def show(id)
		@comment = Comment.get(id)
		raise NotFound unless @comment
		
		display @comment
	end

	def new(slug)
		only_provides :html
		
		@comment = Comment.new
		@post = Post.first(:slug => slug)
		
		render
	end

	def edit(id)
		only_provides :html
		
		@comment = Comment.get(id)
		raise NotFound unless @comment && this_is_mine(@comment)
		
		render
	end

	def create(comment, slug)
		@post = Post.first(:slug => slug)
		
		@comment = Comment.new(comment)
		@comment.person = current_person
		
		@post.comments << @comment
		
		if @comment.valid? && @post.save
			redirect resource(@post) + "/#comment-at-#{@comment.created_time}"
		else
			render :new
		end
	end

	def update(id, comment)
		@comment = Comment.get(id)
		raise NotFound unless @comment && this_is_mine(@comment)
		if @comment.update_attributes(comment)
			redirect resource(:comments)
		else
			display @comment, :edit
		end
	end

	def destroy(id)
		@comment = Comment.get(id)
		
		raise NotFound unless @comment && this_is_mine(@comment)
		if @comment.destroy
			redirect resource(:comments)
		else
			raise InternalServerError
		end
	end
end