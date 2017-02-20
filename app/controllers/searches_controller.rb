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
    @search_option = current_user.searches.new(:search_name => params[:search_name], :market_cap_gteq => search_link[/cap_gteq%5D=(.*?)&q%5Bp_e_ratio_gteq/,1], :p_e_ratio_gteq => search_link[/p_e_ratio_gteq%5D=(.*?)&q%5Bpeg_ratio_gteq/,1], :peg_ratio_gteq => search_link[/peg_ratio_gteq%5D=(.*?)&q%5Bprice_to_sales_ttm_gteq/,1], :price_to_sales_ttm_gteq => search_link[/price_to_sales_ttm_gteq%5D=(.*?)&q%5Bprice_to_book_mrq_gteq/,1], :price_to_book_mrq_gteq => search_link[/price_to_book_mrq_gteq%5D=(.*?)&q%5Bearnings_per_share_gteq/,1], :earnings_per_share_gteq => search_link[/earnings_per_share_gteq%5D=(.*?)&q%5Bmarket_cap_lteq/,1], :market_cap_lteq => search_link[/market_cap_lteq%5D=(.*?)&q%5Bp_e_ratio_lteq/,1], :p_e_ratio_lteq => search_link[/p_e_ratio_lteq%5D=(.*?)&q%5Bpeg_ratio_lteq/,1], :peg_ratio_lteq => search_link[/peg_ratio_lteq%5D=(.*?)&q%5Bprice_to_sales_ttm_lteq/,1], :price_to_sales_ttm_lteq => search_link[/price_to_sales_ttm_lteq%5D=(.*?)&q%5Bprice_to_book_mrq_lteq/,1], :price_to_book_mrq_lteq => search_link[/price_to_book_mrq_lteq%5D=(.*?)&q%5Bearnings_per_share_lteq/,1], :earnings_per_share_lteq => search_link[/earnings_per_share_lteq%5D=(.*?)&commit/,1], :user_id => current_user.id)
    
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
      flash[:notice] = 'Screen parameters updated.'
      redirect_to stocks_path
    else
      render :edit
    end
  end

  def apply_search
    if params[:edit_search]
      @search = current_user.searches.find(params[:select_search])
      render :edit
    else
      #@filter = current_user.searches.find(params[:select_search]).value
      #@search_url = "http://localhost:3000#{@filter}"
      @filter = current_user.searches.find(params[:select_search])
      @sector = Stock.find_by_sql("SELECT sector from stocks group by sector").map &:sector
      @sector = @sector.join(",")
      @industry = Stock.find_by_sql("SELECT industry from stocks group by industry").map &:industry
      @industry = @industry.join(",")
      @cap_gteq = @filter.market_cap_gteq
      @cap_lteq = @filter.market_cap_lteq
      @pe_ratio_gteq = @filter.p_e_ratio_gteq
      @pe_ratio_lteq = @filter.p_e_ratio_lteq
      @peg_ratio_gteq = @filter.peg_ratio_gteq
      @peg_ratio_lteq = @filter.peg_ratio_lteq
      @ps_gteq = @filter.price_to_sales_ttm_gteq
      @ps_lteq = @filter.price_to_sales_ttm_lteq
      @pb_gteq = @filter.price_to_book_mrq_gteq
      @pb_lteq = @filter.price_to_book_mrq_lteq
      @eps_gteq = @filter.earnings_per_share_gteq
      @eps_lteq = @filter.earnings_per_share_lteq
      @filter_url = "http://localhost:3000/stocks?utf8=&q%5Bsector_eq%5D=#{@sector}&q%5Bindustry_eq%5D=#{@industry}&q%5Bmarket_cap_gteq%5D=#{@cap_gteq}&q%5Bp_e_ratio_gteq%5D=#{@pe_ratio_gteq}&q%5Bpeg_ratio_gteq%5D=#{@peg_ratio_gteq}&q%5Bprice_to_sales_ttm_gteq%5D=#{@ps_gteq}&q%5Bprice_to_book_mrq_gteq%5D=#{@pb_gteq}&q%5Bearnings_per_share_gteq%5D=#{@eps_gteq}&q%5Bmarket_cap_lteq%5D=&q%5Bp_e_ratio_lteq%5D=#{@pe_ratio_lteq}&q%5Bpeg_ratio_lteq%5D=#{@peg_ratio_lteq}&q%5Bprice_to_sales_ttm_lteq%5D=#{@ps_lteq}&q%5Bprice_to_book_mrq_lteq%5D=#{@pb_lteq}&q%5Bearnings_per_share_lteq%5D=#{@eps_lteq}&commit=Filter"
      redirect_to @filter_url
    end
  end

  def destroy
    @search = current_user.searches.find(params[:id])
    @search.destroy
    flash[:notice] = "The saved search was deleted."
    redirect_to stocks_path
  end

  private
  def search_params
    params.require(:search).permit(:id, :search_name, :market_cap_gteq, :market_cap_lteq, :p_e_ratio_gteq, :p_e_ratio_lteq, :peg_ratio_gteq, :peg_ratio_lteq, :price_to_sales_ttm_gteq, :price_to_sales_ttm_lteq, :price_to_book_mrq_gteq, :price_to_book_mrq_lteq, :earnings_per_share_gteq, :earnings_per_share_lteq)
  end
  #  params.require(:search).permit(:user_id => current_user.id, :value => params[:q])
  #end
end
