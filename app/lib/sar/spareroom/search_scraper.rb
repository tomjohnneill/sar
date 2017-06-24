module SAR
  module Spareroom
    class SearchScraper
      def run(postcode, dss='Y')
        params = default_params.merge(search: postcode, dss: dss)
        index_response = agent.get(url, params)

        puts "Search Index Postcode: #{postcode}"

        data = SearchResultPaginator.new(agent, index_response).run

        insights = Insights.new(data)
        insights.to_json
      end

      def agent
        @agent ||= Mechanize.new
      end

      def url
        'https://www.spareroom.co.uk/flatshare/search.pl"'
      end

      def default_params
        {
          action: 'search',
          available_search: 'N',
          flatshare_type: 'offered',
          location_type: 'area',
          search: 'SW1',
          showme_rooms: 'Y',
          showme_1beds: '',
          showme_buddyup_properties: '',
          min_rent: '1',
          max_rent: '99999',
          per: '',
          bills_inc: '',
          dss: 'Y'
        }
      end
    end
  end
end
