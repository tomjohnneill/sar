module SAR
  module Spareroom
    class SearchResultPage
      def initialize(response)
        @response = response
        @response.search(xpath_price_within_comments).each do |element|
          price = parse_price(element)
          unless price.empty?
            results << (price.to_i)
          end
        end
      end

      def next_page
        unless is_last?
          @response.at(xpath_next_page_link)
        end
      end

      def results
        @results ||= []
      end

      def is_last?
        if @response.at(xpath_next_page_link)
          return false
        else
          return true
        end
      end

      private

      def parse_price(element)
        element.to_s.gsub(/\D/, '')
      end

      def xpath_next_page_link
        '//*[@id="maincontent"]/div[2]/ul[2]/li/strong/a'
      end

      def xpath_price_within_comments
        '//*[@id="maincontent"]/ul/li/article/header[1]/a/strong/comment()'
      end

    end
  end
end