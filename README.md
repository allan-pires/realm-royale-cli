# Realm Royale CLI
<img src='https://cdn.cloudflare.steamstatic.com/steam/apps/813820/capsule_616x353.jpg?t=1593100106'>

## About
This is a simple CLI tool for fetching data from the Realm Royale API.

## How to use:
Clone the repo and run bundle install:
```bash
$ bundle install
```

Create a new `.env` based on the `.env.example` and replace the variables:
```
REALM_API_URL=https://sampleapiurl.com
REALM_API_DEV_ID=1234
REALM_API_KEY=ABC1234DEF1234G1234H1234
```

Add a list of player names and their steam ids you want to query to your `.env`:
```
VALID_STEAM_IDS={ "sample_username": 123456789 }
```

Run the script:
```bash
$ ruby main.rb -p sample_username
```

You should see a response like this:
```bash
{:games_played=>79,
 :wins=>17,
 :losses=>62,
 :kills_player=>142,
 :deaths=>94,
 :average_placement=>12}
```
Please note that you need Ruby installed to run this.

Available options:
```bash
Usage: main.rb [options]
    -h, --help                       Prints this help
    -p, --player                     Show player info
    -a, --all-players                Show all players info
    -l, --list                       List valid players
```
