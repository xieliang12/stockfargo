class PostsController < ApplicationController
  before_action :set_favorite
  before_action :authenticate_user!

  def index
    @posts = @favorite.posts.all
  end

  def new
    @post = @favorite.posts.build
  end

  def create
    @post = @favorite.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { render action: "index", notice: "the post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @post = @favorite.posts.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.present?
      @post.destroy
    end

    respond_to do |format|
      format.html { redirect_to favorite_posts_path }
      format.js
    end
  end

  private

  def set_favorite
    @user = current_user
    @favorite = @user.favorites.find(params[:favorite_id])
  end

  def post_params
    params.require(:post).permit(:title, :post_type, :text, :sentiment).merge(author_id: current_user.id)
  end

end
