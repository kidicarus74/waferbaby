#
#	posts.rb
#	Copyright (c) 2008-2009 Daniel Bogan. http://waferbaby.com/
#

require 'categories_helper'

class Posts < Application
	before :admin_required, :only => [:new, :edit, :delete, :update, :destroy]
        provides :atom, :text, :xml

        def index
                @count, @posts = Post.paginated(:order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => PAGE_SIZE)
                display @posts
        end
        
        def index_by_date(created_year, created_month = nil, created_day = nil)
                created_month = '__' if created_month == nil
                created_day   = '__' if created_day   == nil
                
                date = "#{created_year}-#{created_month}-#{created_day}%"
                @count, @posts = Post.paginated(:created_at.like => date, :order => [:created_at.desc], :page => params[:page] ? params[:page].to_i : 1, :per_page => PAGE_SIZE)
                
                display @posts, :index
        end
        
        def index_by_category(category)
                @category = Category.first(:slug => category)
                raise NotFound unless @category && @category.posts
                
                @posts = @category.posts
                
                display @posts, :index
        end
        
        def show(slug)
                @post = Post.first(:slug => slug)
                raise NotFound unless @post
                
                @post.is_selected = true
                
                render :show
        end

	def new
		only_provides :html
		@post = Post.new
		display @post
	end

	def edit(slug)
		only_provides :html
		@post = Post.first(:slug => slug)
		raise NotFound unless @post
		display @post
	end

	def create(post)
		@post = Post.new(post)
		if @post.save
			redirect resource(@post)
		else
			session[:message] = "Post failed to be created"
			render :new
		end
	end

	def update(slug, post)
		@post = Post.first(:slug => slug)
		raise NotFound unless @post
		if @post.update_attributes(post)
			redirect resource(@post)
		else
			display @post, :edit
		end
	end

	def destroy(slug)
		@post = Post.first(:slug => slug)
		raise NotFound unless @post
		if @post.destroy
			redirect resource(:posts)
		else
			raise InternalServerError
		end
	end

end
