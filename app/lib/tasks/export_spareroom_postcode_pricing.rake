namespace :sar do
  desc 'Export Spareroom Postcode pricing data'
  task :export_spareroom_postcode_pricing => :environment do |t, args|
    puts 'Exporting price data'

    SAR::ExportSpareroomPostcodePricing.new.run

    puts 'Done'
  end
end
