require 'rails_helper'

RSpec.describe 'Merchants Controller' do
  let!(:merch) {FactoryBot.create_list(:merchant, 20)}
  let!(:items) {FactoryBot.create_list(:item, 100)}
  describe 'show' do
    it 'returns the merchant for an item' do
      item = Item.first
      get "/api/v1/items/#{item.id}/merchant"
      res = JSON.parse(response.body)
      expect(res['data']['id']).to eq(item.merchant_id.to_s)
      expect(res['data']['attributes']['name']).to eq(item.merchant.name)
      expect(res['data']['type']).to eq('merchant')
    end
  end
end