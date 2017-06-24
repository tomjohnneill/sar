class PriceDiscrepancyReportsController < ApplicationController
  def index
  end

  def show
    render json: {
      brma: brma[:name],
      government_allowance: housing_allowance[:lha_rate],
      rent_distribution: housing_allowance[:rents],
      results: {
        spareroom: {
          total_results: spareroom[:total_results],
          highest_rent: spareroom[:highest_rent],
          lowest_rent: spareroom[:lowest_rent],
          mean_rent: spareroom[:mean_rent],
          median_rent: spareroom[:median_rent],
          rooms_below_threshold: rooms_below_threshold
        }
      },
      number_rooms: spareroom[:total_results],
      rooms_below_threshhold: rooms_below_threshold
    }
  end

  private

  def brma
    @brma ||= SAR::BRMA::FindByPostcode.new(params[:postcode]).convert
  end

  def housing_allowance
    @housing_allowance ||= SAR::BRMA::HousingAllowanceFinder.new.exec(brma[:brma])
  end

  def spareroom
    @spareroom ||= SAR::Spareroom::SearchScraper.new.run(params[:postcode])
  end

  def rooms_below_threshold
    @rooms_below_threshold ||= spareroom[:data].select do |price|
      price <= housing_allowance[:lha_rate]
    end.count
  end
end
