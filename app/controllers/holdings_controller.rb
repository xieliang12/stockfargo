class HoldingsController < ApplicationController
  before_action :set_holding, only: [:show, :edit, :update, :destroy, :edit_all, :new]
  before_action :authenticate_user!
  autocomplete :stock, :symbol, { :display_value => 'symbol_with_name', :full_model=>true }
  respond_to :html, :js

  def index
    @holdings = Holding.joins(:portfolio).where(portfolio_id: params[:portfolio_id])
    @portfolio = Portfolio.find(params[:portfolio_id])
  end

  def show
    @holding = Holding.find_by_id(params[:id])
    @portfolio = Portfolio.find_by_id(params[:portfolio_id])
  end

  def new
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
    @holding = @portfolio.holdings.build
  end

  def edit
    @holding = Holding.find_by_id(params[:id])
    @portfolio = current_user.portfolios.find_by_id(params[:portfolio_id])
  end

  def create
    @portfolio = current_user.portfolios.find(params[:portfolio_id])
    @holding = @portfolio.holdings.new(holding_params)
    respond_to do |format|
      if @holding.save
        format.js
        format.html { redirect_to portfolio_path(@portfolio), notice: 'Holding was successfully created.' }
        format.json { render :show, status: :created, location: @holding }
      else
        format.html { render :new }
        format.json { render json: @holding.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @holding = Holding.find(params[:id])
    @portfolio = Portfolio.find(params[:portfolio_id])
    respond_to do |format|
      if @holding.update(holding_params)
        format.html { redirect_to portfolio_path(@portfolio), notice: 'Holding was successfully updated.' }
        format.json { render :show, status: :ok, location: @holding }
      else
        format.html { render :edit }
        format.json { render json: @holding.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @holding = Holding.find(params[:id])
    @holding.destroy
    respond_to do |format|
      format.html { redirect_to portfolio_holdings_url, notice: 'Holding was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def edit_all
    @holding = Holding.joins(:portfolio).where(portfolio_id: params[:portfolio_id])
    @portfolio = Portfolio.find_by_id(params[:portfolio_id])
    @portfolio_test = current_user.portfolios.find_by_id(params[:portfolio_id])
    @holding_add_stock = @portfolio_test.holdings.build
  end

  def update_all
    @portfolio = Portfolio.find(params[:portfolio_id])
    result = Holding.update(params[:holding].keys, params[:holding].values).reject { |p| p.errors.empty? }
    if result.empty?
      flash[:notice] = "Holdings updated."
      redirect_to portfolio_path(@portfolio)
    else
      holding_ids = result.collect {|i| i.id }
      flash[:error] = "Error(s) cccurred updating holding(s): #{holding_ids.join ', '}"
      redirect_to portfolio_edit_all_path(@portfolio)
    end
  end

  private

  def set_holding
    unless @holding = current_user.portfolios.find_by_id(params[:portfolio_id])
      flash[:alert] = 'Holding not found.'
      redirect_to root_url
    end
  end

  def holding_params
    params.require(:holding).permit(:id, :user_id, :stock_id, :symbol, :portfolio_id, :amount, :position, :date_purchased, :trade_price)
  end
end
