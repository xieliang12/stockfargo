class FavoritesController < ApplicationController
  before_action :set_favorite, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  autocomplete :stock, :symbol, { :display_value => 'symbol_with_name', :full_model => true }

  def index
    if params[:tag]
      @favorites = Favorite.tagged_with(params[:tag])
    else
      @favorites = Favorite.all.order('created_at desc')
    end
  end

  def show
    @post = @favorite.posts.build
  end

  def new
    @favorite = current_user.favorites.new
  end

  def edit
  end

  def create
    @favorite = current_user.favorites.new(favorite_params)

    respond_to do |format|
      if @favorite.save
        format.html { redirect_to favorites_path, notice: 'Favorite was successfully created.' }
        format.json { render :index, location: @favorite }
      else
        format.html { render :new}
        format.json { render json: @favorite.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @favorite.destroy
    respond_to do |format|
      format.html { redirect_to favorites_url, notice: 'Favorite was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  #def search
  #  if params[:search].present?
  #    @favorite = current_user.favorites.search(params[:search])
  #  else
  #    @favorite = current_user.favorites
  #  end
  #end

  private

  def set_favorite
    unless @favorite = current_user.favorites.where(id: params[:id]).first
      flash[:alert] = 'Favorite not found.'
      redirect_to root_url
    end
  end

  def favorite_params
    params.require(:favorite).permit(:id, :user_id, :stock_id, :symbol, :tag_list)
  end
end
