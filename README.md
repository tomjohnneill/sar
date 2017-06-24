Hello

### JSON structure exposed to frontend

```json
[
  {
    "brma": "Some Name",
    "government_allowance": 590,
    "average_rent": {
      "spareroom": 830,
      "zoopla": 870
    },
    "number_rooms": 620,
    "rooms_below_threshhold": 0
  }
]
```

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

# Rails

## Booting the app

```sh
docker-compose up
```

Create the database
```sh
sh rails.sh bundle exec rake db:create
sh rails.sh bundle exec rails db:migrate
```

```sh
sh rails.sh
```

## Running commands

```sh
sh rails.sh bundle exec rails db:migrate
```

## Deploying

```sh
git subtree push --prefix app heroku master
```
