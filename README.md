# landchecker-coding-challenge
A submission for Landchecker's backend coding challenge.

# Usage
Ensure both ruby and rails are installed locally.
Run `bundle install` prior to running the app

To add entries to the database, run `rails console`, then `Lga.create`, filling all the relevant fields.

For example:
 property_id: 1623061, council_property_number: "2387900700", full_address: "15 HEROES AVENUE EMERALD 3782", latitude: -37.9325840055048, longitude: 145.444291599465 postcode: "3782"

Once you have added some entries, run `rails s` in your console to start the server. Enter `http://localhost:3000/api/v1/lgas` into your browser to show a paginated index of the LGAs, split into groups of 5.

To access a specific LGA, enter `http://localhost:3000/api/v1/lgas/id`, where id is the ID of an LGA in the database.

# Specs
To run the specs for the LGA controller, enter `rspec spec\controllers\lgas_controller_spec.rb` in the console.
