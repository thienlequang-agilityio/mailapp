class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  respond_to :html

  def index
    @posts = Post.all
    respond_with(@posts)
  end

  def show
    respond_with(@post)
  end

  def new
    @post = Post.new
    respond_with(@post)
  end

  def edit
  end

  def create
    @user = current_user
    @post = @user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        PostMailer.post_created(@user).deliver

        format.html {redirect_to @post, notice: "Post was successfully created."}
        format.json {render :show, status: :created, location: @post }
      else
        format.html {render :new}
        format.json {render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @post.update(post_params)
    respond_with(@post)
  end

  def destroy
    @post.destroy
    respond_with(@post)
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
end
