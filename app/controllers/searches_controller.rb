class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @searches = current_user.searches.order("search_name")
  end
  
  def new
    @search = current_user.searches.new
  end

  def saved_search_add
    search_link = params[:q].gsub(/&search_name=(.*)$/,'')
    @search_option = current_user.searches.new(:search_name => params[:search_name], :value => search_link, :user_id => current_user.id)
    
    respond_to do |format|
      if @search_option.save
        format.html { redirect_to :back }
        flash[:notice] = "Search was saved."
      else
        format.html { redirect_to :back }
        format.json { redirect_to :back }
      end
    end
  end

  def edit
    @search = current_user.searches.find(params[:id])
  end

  def update
    @search = current_user.searches.find(params[:id])
    if @search.update(search_params)
      redirect_to stocks_url, notice: 'Screen parameters updated.'
    else
      render :edit
    end
  end

  def apply_search
    if params[:edit_search]
      @search = current_user.searches.find(params[:select_search])
      render :edit
    else
      @filter = current_user.searches.find(params[:select_search]).value
      @search_url = "http://localhost:3000#{@filter}"
      redirect_to @search_url
    end
  end

  private
  def search_params
    params.require(:search).permit(:id, :search_name, :value)
  end
  #  params.require(:search).permit(:user_id => current_user.id, :value => params[:q])
  #end
end
