class PostsController < ApplicationController
  before_action :find_post, except: [:index, :new, :create]
  def index
    #ActiveRecord gives us queries like Post.all. See app/models/post.rb 
    #GET all the posts from the posts table in DB
  if params[:featured].present? and params[:featured] =="true"
    #GET only the featured posts
    @posts = Post.where(is_featured:true).order("created_at desc")
  else

  	@posts = Post.order("created_at desc")
  end
  end

  def show
    #GET the post with the id from the url
  	#@post = Post.find(params["id"])
    @comments = @post.comments
  end
#############
  	def new
    @post = Post.new
  	end
# the new form gets submitted to the create action
  	def create
      @post = Post.new(post_params)
      if @post.save
        flash[:success] = "Thanks for posting!"
        redirect_to root_path
      else 
        flash[:error] ="Oops, something went wrong. Please try again"
        render :new
      end
  	end
 
#############
  	def edit
 #     @post =Post.find(params[:id])
  	end
#The edit form gets submitted to the update action
  	def update
  #    @post =Post.find(params[:id])
      if @post.update(post_params)
        flash[:success] ="Updated '#{@post.title}'"
        redirect_to post_path(@post)
      else
        render :edit
        flash[:error] ="ERROR"
      end
 	  end
#############
    def destroy
      flash[:success] ="Successfully deleted"
   #   @post = Post.find(params[:id])
      @post.destroy
      redirect_to root_path
    end
    
 private
 def post_params
  #allow attrivutes that i trust, ignore any scary malicious unsanctioned evil data
    params.require(:post).permit(:title, :body, :is_published, :is_featured)
  end

  def find_post
      @post = Post.find(params[:id])
  end
end


