module SAR
  module Spareroom
    class Insights
      def initialize(data)
        @data = data
      end

      def mean
        (@data.reduce(0, :+)/total_results)
      end

      def median
        sorted = @data.sort
        len = sorted.length
        (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
      end

      def highest
        @data.sort.last
      end

      def lowest
        @data.sort.first
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
          median_rent: median
        }
      end

    end
  end
end