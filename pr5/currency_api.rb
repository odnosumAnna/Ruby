require 'net/http'
require 'json'
require 'csv'

class CurrencyAPI
  API_URL = 'https://open.er-api.com/v6/latest'

  def initialize(base_currency)
    @base_currency = base_currency
  end

  def fetch_exchange_rates
    uri = URI("#{API_URL}/#{@base_currency}")
    response = Net::HTTP.get_response(uri)

    if response.is_a?(Net::HTTPSuccess)
      data = JSON.parse(response.body)
      rates = extract_rates(data)
      print_rates(rates)
      rates
    else
      raise "Failed to fetch data from API: #{response.message}"
    end
  end

  def save_to_csv(rates, filename)
    CSV.open(filename, 'w') do |csv|
      csv << ['Currency', 'Rate']
      rates.each do |rate|
        csv << [rate[:currency], rate[:rate]]
      end
    end
    puts "Data saved to #{filename}"
  end

  private

  def extract_rates(data)
    rates = data['rates']
    rates.map { |currency, rate| { currency: currency, rate: rate } }
  end

  def print_rates(rates)
    puts "Exchange rates for #{@base_currency}:"
    rates.each do |rate|
      puts "#{rate[:currency]}: #{rate[:rate]}"
    end
  end
end

# Приклад використання класу
api = CurrencyAPI.new('USD')
rates = api.fetch_exchange_rates
api.save_to_csv(rates, 'exchange_rates.csv')
