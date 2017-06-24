require 'csv'
require 'json'

module SAR
  module BRMA
    class HousingAllowanceFinder
      def exec(brma_number)
        base_data, rent_data = find_by(brma_number)

        {
          bmra_name: base_data['BRMAname'],
          lha_rate: base_data['LHArate'].to_f,
          rents: rent_data
        }
      end

      private

      def find_by(brma_number)
        base_data = parsed_csv.find { |row| row['BRMAno'].to_i == brma_number }
        rent_data = rent_data[brma_number]

        [base_data, rent_data]
      end

      def parsed_csv
        CSV.read(Rails.root.join('fixtures', 'brma.csv'), headers: true)
      end

      def rent_data
        file = File.read(Rails.root.join('fixtures', 'rents.json'))
        JSON.parse(file)
      end
    end
  end
end
