# Online Pizzeria
This is a Ruby on Rails 5 application that allows users to order pizza at the comfort of their homes.

## External dependencies
This web application is written with Ruby using the Ruby on Rails framework and a PostgreSQL database

## Installation
Once you have Ruby, Rails and PostgreSQL installed. Take the following steps to install the application:
 - Run `git clone https://github.com/JoyyToo/onlinePizzaOrdering.git` to clone this repository

 - Run `bundle install` to install all required gems
 
## This project uses Postgresql. You will need to install postgres.On a Mac do:
- Run `brew install postgres`

## To create the databases:
- Run
   - `rails db:create`
   
   - `rails db:migrate`

## To have sample data in your database:
- Run `rails db:seed`

## How to run the test suite
- Run test with `rspec spec`

## Run the server
- Run `rails s`