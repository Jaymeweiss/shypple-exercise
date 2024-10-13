namespace :db do
  desc "Populate the database with sample data"
  task populate: :environment do
    require "json"
    require_relative "../../app/models/application_record"
    require_relative "../../app/models/shipping_option"
    require_relative "../../app/models/rate"
    require_relative "../../app/models/exchange_rate"

    # Define the path to the JSON file
    file_path = Rails.root.join("response_example.json")

    # Read and parse the JSON file
    file = File.read(file_path)
    data = JSON.parse(file)

    # Iterate over the parsed data and create database entries
    ActiveRecord::Base.transaction do
      data["sailings"].each do |sailing|
        ShippingOption.find_or_create_by!(
          origin_port: sailing["origin_port"],
          destination_port: sailing["destination_port"],
          departure_date: sailing["departure_date"],
          arrival_date: sailing["arrival_date"],
          sailing_code: sailing["sailing_code"]
        )
      end

      data["rates"].each do |rate|
        Rate.find_or_create_by!(
          sailing_code: rate["sailing_code"],
          rate: rate["rate"],
          rate_currency: rate["rate_currency"]
        )
      end

      data["exchange_rates"].each do |date, rates|
        rates.each do |currency, rate|
          ExchangeRate.find_or_create_by!(
            date: date,
            currency: currency.upcase,
            rate: rate
          )
        end
      end
    end
  end
end
