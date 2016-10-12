class ReportsController < ApplicationController
  def index
    @result = run_command(params[:ticker])
  end

  private

  def run_command(para)
    `ls -#{para}`
  end
end
