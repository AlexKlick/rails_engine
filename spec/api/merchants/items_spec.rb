require 'rails_helper'

RSpec.describe 'Items Controller' do
  describe 'index' do
    let!(:merch) {FactoryBot.create_list(:merchant, 1)}
    let!(:items) {FactoryBot.create_list(:item_one_merch, 10)}
    it 'returns all of the items for a merchant' do
      merchant = Merchant.first
      get "/api/v1/merchants/#{merchant.id}/items"
      res = JSON.parse(response.body)
      expect(res['data'].length).to eq(10)
      expect(res['data'][0]['attributes']['name']).to eq(Item.first.name)
    end
  end
end
