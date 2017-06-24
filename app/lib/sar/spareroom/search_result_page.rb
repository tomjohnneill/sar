module SAR
  module Spareroom
    class SearchResultPage
      def initialize(response)
        @response = response
        @response.search(xpath_price_within_listings).each do |element|
          price = parse_price(element)
          unless price.empty?
            price_as_int = price.to_i
            price_pw = convert_display_price_to_pw(price_as_int, element)
            results << (price_pw)
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
        element.xpath('//comment()').remove
        element.to_s.scan(/\d+/).first
      end

      def convert_display_price_to_pw(price, element)
        if is_pcm?(element)
          return (price * 12)/52
        else
          return price
        end
      end

      def is_pcm?(element)
        if element.to_s.include?("pcm")
          return true
        else
          return false
        end
      end

      def xpath_next_page_link
        '//*[@id="maincontent"]/div[2]/ul[2]/li/strong/a'
      end

      def xpath_price_within_listings
        '//*[@id="maincontent"]/ul/li/article/header[1]/a/strong'
      end

    end
  end
end