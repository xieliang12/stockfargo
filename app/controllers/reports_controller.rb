class ReportsController < ApplicationController
  include ReportsHelper::Feature

  def index
    ticker = params[:ticker]
    $current_date = Time.now.strftime("%Y%m%d")
    link = "https://s3-us-west-2.amazonaws.com/mystocks/reports/#{ticker}/#{ticker}_dchart_#{$current_date}.png" 
    #if Geturl.check_url(@result.select {|x| x =~ /_dchart_#{$current_date}/}[0]) != "200"
    if Geturl.check_url(link) != "200" && !ticker.nil?
      plot_charts_insider(ticker)
      if params[:biotech]
        get_patents(ticker)
        get_publications(ticker)
        get_clinicals(ticker)
      end
      upload_data(ticker)
    end

    @result = create_url(ticker)

    @patent_file = Dir.glob("/Users/xieliang12/ruby/stock_analysis_app/data/#{ticker}/*").grep(/patents_#{$current_date}/)[0]
    if !@patent_file.nil? 
      gon.patents = JSON.parse(File.read(@patent_file))
    end
  
    @pub_file = Dir.glob("/Users/xieliang12/ruby/stock_analysis_app/data/#{ticker}/*").grep(/publications_#{$current_date}/)[0]
    if !@pub_file.nil? 
      gon.publications = JSON.parse(File.read(@pub_file))
    end
  end

  #gon.patents = [{"patent_id": "20160206729","inventor": "SMITH; Gale; et al.","report_date": "July 21, 2016", "title": "IMMUNOGENIC MIDDLE EAST RESPIRATORY SYNDROME CORONAVIRUS (MERS-CoV) COMPOSITIONS AND METHODS"}, { "patent_id": "20160184427","inventor": "Morein; Bror; et al.","report_date": "June 30, 2016","title": "QUIL A FRACTION WITH LOW TOXICITY AND USE THEREOF"}]

  private
  def plot_charts_insider(symbol)
    system ("ruby /Users/xieliang12/ruby/stock_analysis_app/plot_charts_fromR.rb #{symbol}")
  end
  
  def get_patents(symbol)
    system ("ruby /Users/xieliang12/ruby/stock_analysis_app/get_patents.rb #{symbol}")
  end

  def get_publications(symbol)
    system ("ruby /Users/xieliang12/ruby/stock_analysis_app/get_ncbi_publications.rb #{symbol}")
  end

  def get_clinicals(symbol)
    system ("ruby /Users/xieliang12/ruby/stock_analysis_app/clinicals_plot.rb #{symbol}")
  end

  def create_url(symbol)
    prefixes = ["_insider_", "_dchart_", "_wchart_", "_mchart_", "_clinical_"]
    links = [] 
    prefixes.each do |fix|
      link = "https://s3-us-west-2.amazonaws.com/mystocks/reports/#{symbol}/#{symbol}#{fix}#{$current_date}.png"
      links << link if Geturl.check_url(link) == "200"
    end
    return links
  end

  def upload_data(symbol)
    system ("/Users/xieliang12/ruby/stock_analysis_app/upload_data_to_S3.sh #{symbol}")
  end

end
  #links.reject! { |link| Geturl.check_url(link) == "200" }

#  def run_command(symbol)
#    system ("ruby /Users/xieliang12/ruby/stock_analysis_app/get_patent_ncbi.rb #{symbol}")
#  end

# the code below is for returning the daily, weekly and monthly chart from finviz
#  def create_url(symbol)
#    periods = ["d", "w", "m"]
#    links = []
#    periods.each do |l|
#      links << "http://finviz.com/chart.ashx?t=#{symbol}&ty=c&ta=0&p="+l+"&s=l"
#    end
#    links << "http://chart.finance.yahoo.com/z?s=#{symbol}&t=1y&q=c&l=off&z=l&p=e15,m50,m200,v&a=r14,fs"
#    links.reject! { |link| Geturl.check_url(link) != "200" }
#    return links
#  end
