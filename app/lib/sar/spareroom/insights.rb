module SAR
  module Spareroom
    class Insights
      def initialize(data)
        @data = data.sort
      end

      def mean
        (@data.reduce(0, :+)/total_results)
      end

      def median
        (@data[(total_results - 1) / 2] + @data[total_results / 2]) / 2.0
      end

      def highest
        @data.last
      end

      def lowest
        @data.first
      end

      def total_results
        @data.length
      end

      def to_json
        {
          total_results: total_results,
          highest_rent: highest,
          lowest_rent: lowest,
          mean_rent: mean,
          median_rent: median,
          data: @data
        }
      end

    end
  end
end
