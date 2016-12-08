module ReportsHelper
  module Feature
    class Geturl 
      def self.check_url(url_address)
        begin
          url = URI.parse(url_address)
          req = Net::HTTP.new(url.host, url.port)
          res = req.request_head(url.path)
          return res.code
        rescue => e
          puts "Exception: #{e}"
        end
      end
    end
  end
end

