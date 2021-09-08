require 'rails_helper'

RSpec.describe 'Merchants controller' do
  before(let!(:merch) {FactoryBot.create_list(:merchant, 20)})
  describe 'merchants index' do
    before {get '/api/v1/merchants'}
    it "responds in JSON with a 'data' key with 'id', 'type', and 'attributes' sub-keys" do
      res = JSON.parse(response.body)
      merchant = Merchant.first
      expect(res['data'][0]['id']).to eq(merchant.id)
      expect(res['data'][0]['attributes']['name']).to eq(merchant.name)
      expect(res['data'][0]['type']).to eq('merchant')
    end
    before {get '/api/v1/merchants'}
    it 'returns 20 first merchants' do
      res = JSON.parse(response.body)
      expect(res['data'].length).to eq(20)
    end
  end
  describe 'merchants show' do
    let!(:merch) {FactoryBot.create_list(:merchant, 20)}
    before {get "/api/v1/merchants/#{Merchant.first.id}"}
    it 'returns a single merchant from id' do
      res = JSON.parse(response.body)
      merchant = Merchant.first
      expect(res['data'][0]['id']).to eq(merchant.id)
      expect(res['data'][0]['attributes']['name']).to eq(merchant.name)
      expect(res['data'][0]['type']).to eq('merchant')
    end
  end
end