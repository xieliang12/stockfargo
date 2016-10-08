class ResearchesController < ApplicationController
  before_action :set_favorite
  before_action :authenticate_user!

  def index
    @researches = @favorite.researches.all
  end

  def new
    @research = @favorite.researches.build
  end

  def create
    @research = @favorite.researches.build(research_params)
    respond_to do |format|
      if @research.save
        format.html { redirect_to favorite_researches_path, notice: 'Attachment was added.' }
        format.json { render :index, location: @favorite }
      else
        format.html { render :new }
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @research = Research.find(params[:id])
    @research.destroy
    respond_to do |format|
      format.html { redirect_to favorite_researches_path }
      format.json
    end
  end

  private

  def set_favorite
    @favorite = current_user.favorites.find(params[:favorite_id])
  end

  def research_params
    params.require(:research).permit(:title, :attach).merge(user_id: current_user.id)
  end
end
