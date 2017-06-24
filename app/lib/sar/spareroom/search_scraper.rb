module SAR
  module Spareroom
    class SearchScraper
      def run(postcode)
        params = default_params.merge(search: postcode)
        index_response = agent.get(url, params)

        puts "Search Index Postcode: #{postcode}"

        paginate = SearchResultPaginator.new(agent, index_response)
        paginate.run
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
          year_avail: '',
          mon_avail: '',
          day_avail: '',
          days_of_wk_available: '',
          editing: '',
          ensuite: '',
          flatshare_type: 'offered',
          genderfilter: 'none',
          keyword: '',
          location_type: 'area',
          max_age_req: '',
          max_beds: '',
          max_rent: '',
          max_term: '0',
          miles_from_max: '0',
          min_age_req: '',
          min_beds: '',
          min_rent: '',
          min_term: '0',
          bills_inc: 'Yes',
          mode: '',
          nmsq_mode: '',
          no_of_rooms: '',
          per: '',
          posted_by: '',
          photoadsonly: '',
          room_types: '',
          rooms_for: '',
          search: 'SW1',
          searchtype: 'advanced',
          share_type: '',
          show_results: '',
          showme_1beds: 'Y',
          showme_buddyup_properties: 'Y',
          showme_rooms: 'Y',
          smoking: '',
          templateoveride: ''
        }
      end
    end
  end
end