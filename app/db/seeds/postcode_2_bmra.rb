require 'csv'

CSV.foreach("#{File.dirname(__FILE__)}/postcodesector_2_brma.csv") do |row|
  Postcode2Bmra.create!(
    postcode: row[0].gsub(' ', ''),
    bmra: row[1],
    name: row[2]
  )
end
