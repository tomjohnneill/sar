Hello

### JSON structure exposed to frontend

[
  {
    "brma": "Some Name",
    "government_allowance_percentage": 73
    "government_allowance": 590,
    "average_rent": {
      "spareroom": 830,
      "zoopla": 870
    }
  }
]

### brma
Broad Rental Market Areas

### User flow
User enters postcode
User hits submit
Calculate BRMA from postcode (cache)
Get goverment allowance from BRMA
Scrape Spareroom to get number of result pages
Scrape each Spareroom page and grab rent prices
Calculate Spareroom average rent for postcode
Compare discrepancy between goverment allowance and Spareroom average
Present to user
