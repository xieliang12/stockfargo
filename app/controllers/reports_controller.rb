class ReportsController < ApplicationController
  include ReportsHelper::Charts

  def index
    ticker = params[:ticker]
    @result = create_url(ticker)
    if run_command(ticker) == true
      gon.patents = JSON.parse(File.read(Dir["/Users/xieliang12/ruby/stock_analysis_app/data/#{ticker}/#{ticker}_patents_*.json"][0]))
      gon.publications = JSON.parse(File.read(Dir["/Users/xieliang12/ruby/stock_analysis_app/data/#{ticker}/#{ticker}_publications_*.json"][0]))
    end
  end
    #gon.patents = [{"patent_id": "20160206729","inventor": "SMITH; Gale; et al.","report_date": "July 21, 2016", "title": "IMMUNOGENIC MIDDLE EAST RESPIRATORY SYNDROME CORONAVIRUS (MERS-CoV) COMPOSITIONS AND METHODS"}, { "patent_id": "20160184427","inventor": "Morein; Bror; et al.","report_date": "June 30, 2016","title": "QUIL A FRACTION WITH LOW TOXICITY AND USE THEREOF"}]

  private

  def create_url(symbol)
    periods = ["d", "w", "m"]
    links = []
    periods.each do |l|
      links << "http://finviz.com/chart.ashx?t=#{symbol}&ty=c&ta=0&p="+l+"&s=l"
    end
    links << "http://chart.finance.yahoo.com/z?s=#{symbol}&t=1y&q=c&l=off&z=l&p=e15,m50,m200,v&a=r14,fs"
    links.reject! { |link| Geturl.check_url(link) != "200" }
    return links
  end
  
  def run_command(symbol)
    system ("ruby /Users/xieliang12/ruby/stock_analysis_app/get_patent_ncbi.rb #{symbol}")
  end
end
