# README
Created at the beggining of my journey in Ruby on Rails.

Developed using Rails 7, Hotwire's Turbo & Stimulus technology, Devise, Carrierwave,
Tailwind, Flowbite and many more. Cryptocurrency data provided by CoinGecko API.

Application built for non-commercial use. As it name say, all I need to have in one place is
in this app :) In future I'll add a powerful tool to scan multi chains and return data types,
transactions amount and volume. I believe tool like that should help many crypto-enthusiast to control
their activity in the blockchain world. I am open to suggestions regarding the development 
of already existing features.

# SETUP

To run the application you need installed Docker:

1. In terminal go to apps directory and build app by `docker compose build`.
2. Then run the command `docker compose up`
3. If everything has been installed, perform a migration `bundle exec rails db:migrate`
4. Application should be available at port 3000

To open the container terminal:
1. Open local terminal
2. Run command `docker ps` and copy the container ID
3. Run command `docker exec -it <container ID> sh`

# TODO

1. General tasks
- Custom error pages
- New background

2. User uploads
- More file icons
- Sorting files system

3. Crypto Dashboard
- More specific tests
