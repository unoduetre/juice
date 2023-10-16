# Juice Technical Test
## Setup

### Clone the repository

```zsh
$ git clone 'https://github.com/unoduetre/juice.git'
$ cd juice
```

### Retrieve Alpha Vantage API key

1. Click [here](https://www.alphavantage.co/support/) and generate the API key.
2. Copy the `.env.example` file.
```zsh
$ cp .env.example .env
```
2. Edit the `.env` file and follow the comments there.

### Install ruby and node

I assumed you use [rbenv](https://github.com/rbenv/rbenv) and [nodenv](https://github.com/nodenv/nodenv) for (respectively) ruby and node version management.
If you use other tools, change the following lines accordingly.

Do:
```zsh
$ rbenv install
$ nodenv install
```

### Install packages

Do:
```zsh
$ bundle
$ yarn
```

### Initialize the database

Do:
```zsh
$ ./bin/rails db:setup
$ ./bin/rails db:migrate
$ RAILS_ENV=test ./bin/rails db:migrate
```

### Run tests

Run the tests to check, if you have set up the application correctly.

To run server-side tests, do:
```
$ ./bin/rspec
```

To run client-side tests, do:
```
$ yarn test
```

If all tests pass, the application has been set up succesfully.

## Start the application

Do:
```zsh
$ ./bin/dev
```

Separately start `sidekiq`:
```zsh
$ ./bin/sidekiq
```

## How to use

External API calls are made every 5 minutes.

After entering the stock symbol, e.g. "IBM" or "CAN", you should wait 5 min. until the data is populated from the API.

Internal API calls are made every 3 seconds.

The last column is the volume.
