class PostsController < ApplicationController
  before_action :set_favorite, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def index
    @posts = @favorite.posts.all
  end

  def create
    @favorite = current_user.favorites.find(params[:favorite_id])
    @post = @favorite.posts.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to favorite_path(@favorite), notice: "the post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @favorite = current_user.favorites.find(params[:favorite_id])
    @post = @favorite.posts.find(params[:id])
  end

  def destroy
    @post = @favorite.posts.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to @favorite }
      format.js
    end
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:favorite_id])
  end

  def post_params
    params.require(:post).permit(:id, :title, :post_type, :text, :sentiment).merge(author_id: current_user.id)
  end

end
