class SearchesController < ApplicationController
  before_action :authenticate_user!

  def index
    @searches = current_user.searches.all
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

  #private

  #def search_params
  #  params.require(:search).permit(:user_id => current_user.id, :value => params[:q])
  #end
end
