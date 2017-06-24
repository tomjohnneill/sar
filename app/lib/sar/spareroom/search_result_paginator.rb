module SAR
  module Spareroom
    class SearchResultPaginator
      def initialize(agent, search_response)
        @agent = agent
        @response = search_response
      end

      def run
        fetch_page
      end

      def results
        @results ||= []
      end

      private

      def current_page
        @current_page ||= 0
      end

      def fetch_page
        page = SearchResultPage.new(@response)

        puts "Fetched URI: #{@response.uri}"
        puts "HTTP Response: #{@response.code}"
        puts "Prices Extracted: #{page.results}"

        unless page.is_last?
          next_page
        end
      end

      def next_page
        current_page++
        fetch_page
      end
    end
  end
end