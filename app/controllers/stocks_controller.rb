class StocksController < ApplicationController

  def index
    @search = Stock.search(params[:q])
    @stocks = @search.result
    @sector = Stock.find_by_sql("SELECT sector from stocks group by sector").map &:sector
    @industry = Stock.find_by_sql("SELECT industry from stocks group by industry").map &:industry
  end

  def show
    @stock = Stock.find(params[:id])
  end

  private

  def stock_params
    params.require(:stock).permit(:symbol)
  end
end
  
#  def index
#    @overview = Stock.all.select('symbol, company_name, sector, industry, 
#                             market_cap, p_e_ratio, volume').
#                             paginate(:page => params[:page], :per_page => 15)
#  end

#  def valuation
#    @valuation = Stock.all.select('symbol, market_cap, p_e_ratio, peg_ratio, 
#                              price_to_sales_ttm, price_to_book_mrq, 
#                              earnings_per_share, eps_estimate_next_quarter,
#                              eps_estimate_current_year, fifty_day_moving_average,
#                              percent_change_from_50_day_moving_average, 
#                              two_hundred_day_moving_average,
#                              percent_change_from_200_day_moving_average, 
#                              volume').paginate(:page => params[:page],
#                                                :per_page => 15)
#  end

#  def financial
#    @financial = Stock.all.select('symbol, fifty_two_week_high, fifty_two_week_low,
#                              shares_owned, short_ratio, ebitda, roa_ttm, roe_ttm,
#                              shares_outstanding, pcnt_held_by_insiders,
#                              pcnt_held_by_institutions, pcnt_short_of_float,
#                              operating_cash_flow_ttm, levered_cash_flow_ttm,
#                              book_value_per_share_mrq, volume').
#                              paginate(:page => params[:page], :per_page => 15)
#  end
