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
        #format.json { redirect_to :back, notice: 'Search was saved.' }
      else
        format.html { redirect_to :back }
        format.json { redirect_to :back }
      end
    end
  end

  def apply_search
    @search = current_user.searches.find(params[:select_search]).value
    @search_url = "http://localhost:3000/#{@search}"
    redirect_to @search_url
  end

  #private
  #def search_params
  #  params.require(:select_search).permit(:id, :search_name, :value)
  #end
  #  params.require(:search).permit(:user_id => current_user.id, :value => params[:q])
  #end
end
