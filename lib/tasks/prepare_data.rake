require 'faker'
namespace :prepare_data do

  desc 'create users'
  task create_objects: :environment do
    create_users
    create_loads
    create_jobs
    create_invoices
    create_packages
    create_vehicles
    create_user_vehicles
  end

  def create_users
    100.times do
      User.create!(
        firstname: Faker::Name.name.split(' ')[0],
        surname: Faker::Name.name.split(' ')[1],
        address: Faker::Address.full_address,
        tax_number: Faker::IDNumber.valid,
      )
    end
    puts 'Users created'
  end

  def create_loads
    100.times do
      load = Load.create!(
        start_date: Faker::Date.between(1.year.ago, 1.year.from_now),
        start_location: Faker::Address.full_address,
        end_location: Faker::Address.full_address,
        user: sample(User)
      )
      load.update(end_date: load.start_date + rand(1..20).days)
    end
    puts 'Loads created'
  end

  def create_jobs
    100.times do
      Job.create!(
        user: sample(User),
        load: sample(Load)
      )
    end
    puts 'Jobs created'
  end

  def create_invoices
    100.times do
      Invoice.create!(
        buyer_address: Faker::Address.full_address,
        buyer_name: Faker::Name.name,
        buyer_tax_number: Faker::IDNumber,
        job: sample(Job)
      )
    end
    puts 'Invoices created'
  end

  def create_packages
    100.times do
      Package.create!(
        weight: rand(500..30000),
        kind: Package.kinds.keys.sample,
        load: sample(Load),
      )
    end
    puts 'Packages created'
  end

  def create_vehicles
    100.times do
      Vehicle.create!(
        capacity: rand(500..30000),
        make: Faker::Vehicle.make,
        model: Faker::Vehicle.model,
        year: rand(2000..2018)
      )
    end
    puts 'Vehicles created'
  end

  def create_user_vehicles
    100.times do
      UserVehicle.create!(
        plate_number: Faker::IDNumber.spanish_foreign_citizen_number,
        user: sample(User),
        vehicle: sample(Vehicle),
      )
    end
    puts 'User Vehicles created'
  end

  def sample(model)
    offset = rand(model.count)
    rand_record = model.offset(offset).first
  end
end
