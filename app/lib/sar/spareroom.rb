module SAR
  module Spareroom
    def self.find_price_by_postcode(postcode, dss)
      SAR::Spareroom::SearchScraper.new.run(postcode, dss)
    end
  end
end
