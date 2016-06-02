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

  def edit
    @portfolio = Portfolio.find(params[:id])
  end

  def update
    @portfolio = Portfolio.find(params[:id])
    
    if @portfolio.update(portfolio_params)
      flash[:notice] = "Portfolio has been updated."
      redirect_to @portfolio
    else
      flash.now[:alert] = "Portfolio has not been updated."
      render "edit"
    end
  end

  def destroy
    @portfolio = Portfolio.find(params[:id])
    @portfolio.destroy

    flash[:notice] = "Portfolio has been deleted."
    redirect_to portfolios_path
  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name)
  end

end
