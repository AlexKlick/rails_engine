require 'rails_helper'

RSpec.describe 'Items controller' do
  describe 'Items index' do
    let!(:merch) {FactoryBot.create_list(:merchant, 20)}
    let!(:items) {FactoryBot.create_list(:item, 100)}
    before {get '/api/v1/items'}
    it "responds in JSON with a 'data' key with 'id', 'type', and 'attributes' sub-keys" do
      res = JSON.parse(response.body)
      item = Item.first
      expect(res['data'][0]['id']).to eq(item.id.to_s)
      expect(res['data'][0]['attributes']['name']).to eq(item.name)
      expect(res['data'][0]['type']).to eq('item')
    end
  end
end