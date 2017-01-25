class StocksController < ApplicationController

  def index
    @search = Stock.search(params[:q])
    @stocks = (@search.result).paginate(:page => params[:page], :per_page => 15)
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
