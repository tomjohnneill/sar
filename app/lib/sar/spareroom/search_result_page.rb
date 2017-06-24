module SAR
  module Spareroom
    class SearchResultPage
      def initialize(response)
        response.search('.listingPrice/comment()').each do |element|
          price = parse_price(element)
          unless price.empty?
            results << price
          end
        end
      end

      def results
        @results ||= []
      end

      def is_last?
        true
      end

      private

      def parse_price(element)
        element.to_s.gsub(/\D/, '')
      end

    end
  end
end