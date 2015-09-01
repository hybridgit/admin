namespace :db do
  desc "Populate database tables with sample data"
  task :populate => :environment do
    require 'populator'
    require 'faker'

    # Car Type Setting
    CarType.create({name: "Blue/White Taxi"})
    CarType.create({name: "Airport Yellow Taxi"})

    puts "Car Type Settings Added"

    # Contact Method Setting
    ContactMethod.create({name: "SMS"})
    ContactMethod.create({name: "Phone"})
    ContactMethod.create({name: "Email"})

    puts "Contact Method Settings Added"

    # Operation Hours Setting
    OperationHour.create({name: "Day"})
    OperationHour.create({name: "Night"})

    puts "Operation Hour Settings Added"

    # Relationship Settings
    Relationship.create({name: "Spouse"})
    Relationship.create({name: "Sibling"})
    Relationship.create({name: "Relative"})

    puts "Relationship Settings Added"

    # # Add Locations
    # Location.populate 200 do |location|
    #   location.location_name = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
    #   # Limit latitude from the South and North of Addis Ababa
    #   location.latitude = Float(Faker::Number.between(from = 8.840921, to = 9.089721)).round(6)
    #   # Limit longitude from the West and the East of Addis Ababa
    #   location.longitude = Float(Faker::Number.between(from = 38.659911, to = 38.915183)).round(6)
    #
    #   location.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    # end
    #
    # puts "Locations Added"
    #
    # # Add Drivers
    # Driver.populate 200 do |driver|
    #   driver.name = Faker::Name.name
    #   driver.cell_no = Faker::PhoneNumber.phone_number
    #   driver.location = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
    #   # Limit latitude from the South and North of Addis Ababa
    #   driver.location_lat = Float(Faker::Number.between(from = 8.840921, to = 9.089721)).round(6)
    #   # Limit longitude from the West and the East of Addis Ababa
    #   driver.location_long = Float(Faker::Number.between(from = 38.659911, to = 38.915183)).round(6)
    #
    #   driver.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    # end
    #
    # puts "Drivers Added"
    #
    # # Add Drivers
    # 200.times do |i|
    #   @profile_attr = {
    #     driver_id: i+1,
    #     car_type_id: Faker::Base.rand_in_range(1, 2),
    #     contact_method_id: Faker::Base.rand_in_range(1, 3),
    #     operation_hour_id: Faker::Base.rand_in_range(1, 2),
    #     first_name: Faker::Name.first_name,
    #     last_name: Faker::Name.last_name,
    #     middle_name: Faker::Name.first_name,
    #     drivers_license_id: Faker::Lorem.characters(10),
    #     date_of_birth: Faker::Time.between(70.years.ago, 18.years.ago, :all),
    #     is_active: Faker::Number.between(1, 10) % 2 == 0 ? true : false
    #   }
    #   @profile = Profile.new(@profile_attr)
    #   @address_attr = {
    #     city: Faker::Address.city,
    #     sub_city: Faker::Address.street_name,
    #     woreda: Faker::Address.street_name,
    #     kebele: "#{Faker::Number.between(1, 30)}",
    #     house_number: "#{Faker::Number.number(4)}",
    #     phone_number: Faker::PhoneNumber.phone_number
    #   }
    #   @profile.build_address(@address_attr)
    #   @profile.save
    #
    #   # Also update Driver
    #   @driver = Driver.find(@profile.driver_id)
    #   @driver.profile_id = @profile.id
    #   @driver.save
    # end
    #
    # puts "Drivers Added"
    #
    # # Add Driver Registration Requests
    # DriverRegistrationRequest.populate 200 do |request|
    #   request.cell_no = Faker::PhoneNumber.cell_phone
    #   request.location = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
    #   request.active = Faker::Base.rand_in_range(0, 1) == 0 ? false : true
    #
    #   request.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    # end
    #
    # puts "Driver Registration Requests Added"
    #
    # # Add Cab Requests
    # CabRequest.populate 1000 do |cab_request|
    #   cab_request.location = Faker::Lorem.sentence(word_count = 5, supplemental = false, random_words_to_add = 3)
    #   # Limit latitude from the South and North of Addis Ababa
    #   cab_request.location_lat = Float(Faker::Number.between(from = 8.840921, to = 9.089721)).round(6)
    #   # Limit longitude from the West and the East of Addis Ababa
    #   cab_request.location_long = Float(Faker::Number.between(from = 38.659911, to = 38.915183)).round(6)
    #
    #   cab_request.current_cell_no = Faker::PhoneNumber.cell_phone
    #
    #   # Reference to Driver List
    #   cab_request.driver_id = Faker::Base.rand_in_range(1, 100)
    #
    #   cab_request.created_at = Faker::Date.between(from = Date.today - 3.months, to = Date.today)
    # end
    #
    # puts "Cab Requests Added"

  end
end
