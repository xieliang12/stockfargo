class CommentsController < ApplicationController
  before_action :set_favorite, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  def create
    @favorite = current_user.favorites.find(params[:favorite_id])
    @comment = @favorite.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to favorite_path(@favorite), notice: "the comment was successfully created." }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to @favorite }
      format.js
    end
  end

  private

  def set_favorite
    @favorite = Favorite.find(params[:favorite_id])
  end

  def comment_params
    params.require(:comment).permit(:text).merge(author_id: current_user.id)
  end

end
