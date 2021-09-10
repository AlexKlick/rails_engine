require 'rails_helper'

RSpec.describe 'Merchants controller' do
  describe 'merchants index' do
    let!(:merch) {FactoryBot.create_list(:merchant, 100)}
    it "responds in JSON with a 'data' key with 'id', 'type', and 'attributes' sub-keys" do
      get '/api/v1/merchants'
      res = JSON.parse(response.body)
      merchant = Merchant.first
      expect(res['data'][0]['id']).to eq(merchant.id)
      expect(res['data'][0]['attributes']['name']).to eq(merchant.name)
      expect(res['data'][0]['type']).to eq('merchant')
    end
    it 'returns 20 first merchants' do
      get '/api/v1/merchants'
      res = JSON.parse(response.body)
      expect(res['data'].length).to eq(20)
    end
    it 'returns the first page when asked' do
      get '/api/v1/merchants?page=1&per_page=20'
      res = JSON.parse(response.body)
      expect(res['data'].length).to eq(20)
    end
    it 'defaults to returning 20 merchants if per_page is missing' do
      get '/api/v1/merchants?page=1'
      res = JSON.parse(response.body)
      expect(res['data'].length).to eq(20)
    end
    it 'returns 100 merchants when per_page=100' do
      get '/api/v1/merchants?per_page=100'
      res = JSON.parse(response.body)
      expect(res['data'].length).to eq(100)
    end
    it 'returns all merchants when asked for more than exist' do
      get '/api/v1/merchants?page=1&per_page=2000'
      res = JSON.parse(response.body)
      expect(res['data'].length).to eq(Merchant.count)
    end
  end
  describe 'merchants show' do
    let!(:merch) {FactoryBot.create_list(:merchant, 20)}
    it 'returns a single merchant from id' do
      get "/api/v1/merchants/#{Merchant.first.id}"
      res = JSON.parse(response.body)
      merchant = Merchant.first
      expect(res['data']['id']).to eq(merchant.id.to_s)
      expect(res['data']['attributes']['name']).to eq(merchant.name)
      expect(res['data']['type']).to eq('merchant')
    end
  end
end