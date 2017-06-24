module SAR
  module Spareroom
    def self.find_price_by_postcode(postcode)
      SAR::Spareroom::SearchScraper.new.run(postcode)
    end
  end
end
