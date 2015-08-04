namespace :db do
  desc "Populate database tables with sample data"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    # Add Locations
    Location.populate 200 do |location|
      location.location_name = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
      # Limit latitude from the South and North of Addis Ababa
      location.latitude = Float(Faker::Number.decimal(from = 8.840921, to = 9.089721)).round(6)
      # Limit longitude from the West and the East of Addis Ababa
      location.longitude = Float(Faker::Number.decimal(from = 38.659911, to = 38.915183)).round(6)

      location.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    end

    puts "Locations Added"

    # Add Drivers
    Driver.populate 200 do |driver|
      driver.name = Faker::Name.name
      driver.location = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
      # Limit latitude from the South and North of Addis Ababa
      driver.location_lat = Float(Faker::Number.decimal(from = 8.840921, to = 9.089721)).round(6)
      # Limit longitude from the West and the East of Addis Ababa
      driver.location_long = Float(Faker::Number.decimal(from = 38.659911, to = 38.915183)).round(6)

      driver.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    end

    puts "Drivers Added"

    #Add driver lists
    DriverList.populate 100 do |driver|
      driver.name = Faker::Name.name
      driver.location = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
      # Limit latitude from the South and North of Addis Ababa
      driver.location_lat = Float(Faker::Number.decimal(from = 8.840921, to = 9.089721)).round(6)
      # Limit longitude from the West and the East of Addis Ababa
      driver.location_long = Float(Faker::Number.decimal(from = 38.659911, to = 38.915183)).round(6)

      driver.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    end

    puts "Driver Lists Added"

    # Add Driver Registration Requests
    DriverRegistrationRequest.populate 200 do |request|
      request.cell_no = Faker::PhoneNumber.cell_phone
      request.location = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
      request.active = Faker::Base.rand_in_range(0, 1) == 0 ? false : true

      request.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    end

    puts "Driver Registration Requests Added"

    # Add Cab Requests
    CabRequest.populate 1000 do |cab_request|
      cab_request.location = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
      # Limit latitude from the South and North of Addis Ababa
      cab_request.location_lat = Float(Faker::Number.decimal(from = 8.840921, to = 9.089721)).round(6)
      # Limit longitude from the West and the East of Addis Ababa
      cab_request.location_long = Float(Faker::Number.decimal(from = 38.659911, to = 38.915183)).round(6)

      cab_request.current_cell_no = Faker::PhoneNumber.cell_phone

      # Reference to Driver List
      cab_request.driver_list_id = Faker::Base.rand_in_range(1, 100)

      cab_request.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    end

    puts "Cab Requests Added"

  end
end
