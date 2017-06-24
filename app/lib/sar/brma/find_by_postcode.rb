module SAR
  module BRMA
    class FindByPostcode
      def initialize(postcode)
        @postcode = postcode
      end

      def convert
        if brma_by_postcode
          { status: 'found',
            brma: brma_by_postcode.brma,
            name: brma_by_postcode.name }
        else
          { status: 'not_found' }
        end
      end

      private

      attr_reader :postcode

      def normalized_postcode
        postcode[0..-3].gsub(/[^0-9a-z]/i, '').upcase
      end

      def brma_by_postcode
        @result ||= Postcode2Brma.find_by(postcode: normalized_postcode)
      end
    end
  end
end
