class ReportsController < ApplicationController
  include ReportsHelper::Feature

  def index
    ticker = params[:ticker]
    #@result = create_url(ticker)
    
    if params[:charts]
      plot_charts_insider(ticker)
    end
    
    if params[:patents]
      get_patents(ticker)
    end
    
    if params[:publications]
      get_publications(ticker)
    end
    
    if params[:clinicals]
      get_clinicals(ticker)
    end
    
    if upload_data(ticker) == true
      @result = create_url(ticker)
    end
    #patent_file = Dir.glob("/Users/xieliang12/ruby/stock_analysis_app/data/#{ticker}/*").grep(/patents/)[0]
    #if !patent_file.nil?
    #  patent_name = patent_file.split("/").last
    if get_patents(ticker) == true
      patent_file = Dir.glob("/Users/xieliang12/ruby/stock_analysis_app/data/#{ticker}/*").grep(/patents/)[0]
      gon.patents = JSON.parse(File.read(patent_file))
    end
  
    if get_publications(ticker) == true
      pub_file = Dir.glob("/Users/xieliang12/ruby/stock_analysis_app/data/#{ticker}/*").grep(/publications/)[0]
      gon.publications = JSON.parse(File.read(pub_file))
    end
  end
    #publication_file = Dir.glob("/Users/xieliang12/ruby/stock_analysis_app/data/#{ticker}/*").grep(/publications/)[0]
    #if !publication_file.nil?
  
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
    files = Dir.glob("/Users/xieliang12/ruby/stock_analysis_app/data/#{symbol}/*.png")
    links = []
    files.each do |f|
      link = "https://s3-us-west-2.amazonaws.com/mystocks/reports/#{symbol}/"+f.split("/").last
      links << link
      #if Geturl.check_url(link) != "200"
      #  system ("aws s3 sync #{f.gsub("\/\.", '')} s3://mystocks/reports/#{symbol} --region us-west-2")
      #end
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
