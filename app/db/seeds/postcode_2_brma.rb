require 'csv'

CSV.foreach("#{File.dirname(__FILE__)}/postcodesector_2_brma.csv") do |row|
  Postcode2Brma.create!(
    postcode: row[0].gsub(' ', ''),
    brma: row[1],
    name: row[2]
  )
end
