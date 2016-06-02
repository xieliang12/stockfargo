class PortfoliosController < ApplicationController
  def index
    @portfolios = Portfolio.all
  end

  def new
    @portfolio = Portfolio.new
  end

  def create
    @portfolio = Portfolio.new(portfolio_params)

    if @portfolio.save
      flash[:notice] = "Portfolio has been created."
      redirect_to @portfolio
    else
      flash.now[:alert] = "Portfolio has not been created."
      render "new"
    end
  end

  def show
    @portfolio = Portfolio.find(params[:id])
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name)
  end

end
