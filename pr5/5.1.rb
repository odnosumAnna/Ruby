require 'rspec'
require 'csv'
require 'webmock/rspec'
require_relative 'currency_api'

RSpec.describe CurrencyAPI do
  let(:api) { CurrencyAPI.new('USD') }

  before do
    stub_request(:get, "https://open.er-api.com/v6/latest/USD")
      .to_return(status: 200, body: {
        "rates" => {
          "EUR" => 0.85,
          "GBP" => 0.75
        }
      }.to_json, headers: { 'Content-Type' => 'application/json' })
  end

  describe '#fetch_exchange_rates' do
    it 'повертає курси валют у правильному форматі' do
      rates = api.fetch_exchange_rates
      expect(rates).to be_an(Array)
      expect(rates.first).to include(:currency, :rate)
    end

    it 'повертає успішну відповідь' do
      rates = api.fetch_exchange_rates
      expect(rates).not_to be_nil
    end
  end

  describe '#save_to_csv' do
    it 'створює CSV файл з правильними даними' do
      rates = [{ currency: 'EUR', rate: 0.85 }, { currency: 'GBP', rate: 0.75 }]
      api.save_to_csv(rates, 'test_rates.csv')

      csv_data = CSV.read('test_rates.csv', headers: true)
      expect(csv_data.size).to eq(2)
      expect(csv_data[0]['Currency']).to eq('EUR')
      expect(csv_data[0]['Rate']).to eq('0.85')
      expect(csv_data[1]['Currency']).to eq('GBP')
      expect(csv_data[1]['Rate']).to eq('0.75')
    end
  end
end
# rspec
