module SAR
  module Spareroom
    class SearchResultPaginator
      def initialize(agent, search_result_index_page)
        @agent = agent
        @response = search_result_index_page
      end

      def run
        scrap_page
        flattened_results
      end

      def flattened_results
        results.flatten
      end

      private

      def results
        @results ||= []
      end

      def scrap_page
        page = SearchResultPage.new(@response)
        results << page.results

        puts "Fetched URI: #{@response.uri}"
        puts "HTTP Response: #{@response.code}"
        puts "Prices Extracted: #{page.results}"

        unless page.is_last?
          fetch_next_page(page.next_page)
        end
      end

      def fetch_next_page(url)
        @response = @agent.click(url)
        scrap_page
      end
    end
  end
end