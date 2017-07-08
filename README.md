Hello

### JSON structure exposed to frontend

```json
[
  {
    "brma": "Some Name",
    "government_allowance": 590,
    "results": {
      "spareroom": {
        "total_results": 1099,
        "highest_rent": 830,
        "lowest_rent": 80,
        "mean_rent": 394,
        "median_rent": 215,
        "rooms_below_threshold": 5
      }
    },
    "number_rooms": 1099,
    "rooms_below_threshhold": 5
  }
]
```

### brma
Broad Rental Market Areas

### User flow

* User enters postcode
* User hits submit
* Calculate BRMA from postcode (cache)
* Get goverment allowance from BRMA
* Scrape Spareroom to get number of result pages
* Scrape each Spareroom page and grab rent prices
* Calculate Spareroom average rent for postcode
* Compare discrepancy between goverment allowance and Spareroom average
* Present to user

# Windows

Download Docker Toolbox: https://www.docker.com/products/docker-toolbox
(untick virtual box)

Download latest version of virtual box

Change your virtualization to enabled: http://gateway-us.custhelp.com/app/answers/detail/a_id/37064/~/windows-10%3A-access-the-uefi-bios

Run Docker Toolbox quick start (allow access to everything on the administrator request popups)

ssh docker@[ip] - ip is 
Password: tcuser

tce-load -wi python && curl https://bootstrap.pypa.io/get-pip.py | \
  sudo python - && sudo pip install -U docker-compose

git clone https://github.com/homelesshack/sar

cd sar
cd app
docker-compose up

Csaba's thing

database commands

Go to virtualbox GUI -> default -> settings -> Network -> Advanced -> Port Forwarding -> 'web' 'TCP' Host IP: whatever it says on the console once you started the app port: ditto. guest port: 3000.

Then in the browser go to localhost:3000


# Rails

Install manual for OSX and Ubuntu.

## On Ubuntu 17.04
```sh
sudo apt install docker-compose docker.io
```
To prevent to use `sudo` for docker according this [description](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo) run the following commands:
```sh
sudo groupadd docker
sudo gpasswd -a $USER docker
```
**Now log out/in to activate the changes to groups**

## Booting the app

Creates the docker container
```sh
docker-compose up
```

Install ruby bundles
```sh
sh rails.sh bundle install
```

Create the database
```sh
sh rails.sh bundle exec rake db:create
sh rails.sh bundle exec rails db:migrate
```

Fill the database with data (may take 2-3 minutes)
```sh
sh rails.sh bundle exec rails db:seed
```

Run the web app
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

## Uninstall
Stop the application. **(Ctrl-C)**

The following command removes the docker container
```sh
docker-compose rm
```
