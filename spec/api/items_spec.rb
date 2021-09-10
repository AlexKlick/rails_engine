require 'rails_helper'

RSpec.describe 'Items controller' do
  let!(:merch) {FactoryBot.create_list(:merchant, 20)}
  let!(:items) {FactoryBot.create_list(:item, 100)}
  describe 'Items index' do
    it "responds in JSON with a 'data' key with 'id', 'type', and 'attributes' sub-keys" do
      get '/api/v1/items'
      res = JSON.parse(response.body)
      item = Item.first
      expect(res['data'][0]['id']).to eq(item.id.to_s)
      expect(res['data'][0]['attributes']['name']).to eq(item.name)
      expect(res['data'][0]['type']).to eq('item')
    end
  end
  describe 'Items Show' do
    it 'shows one item by id' do
      item = Item.first
      get "/api/v1/items/#{item.id}"
      res = JSON.parse(response.body)
      item = Item.first
      expect(res['data']['id']).to eq(item.id.to_s)
      expect(res['data']['attributes']['name']).to eq(item.name)
      expect(res['data']['type']).to eq('item')
    end
  end
  describe 'Item create' do
    it 'creates an item from params' do
      post "/api/v1/items?item[name]=abc&item[description]=hi&item[merchant_id]=#{Merchant.first.id}&item[unit_price]=100"
      
      res = JSON.parse(response.body)
      expect(res['data']['id'].to_i).to eq(Item.last.id)
      expect(res['data']['attributes']['name']).to eq(Item.last.name)
      expect(res['data']['attributes']['description']).to eq(Item.last.description)
      expect(res['data']['attributes']['unit_price']).to eq(Item.last.unit_price)
      expect(res['data']['attributes']['merchant_id']).to eq(Item.last.merchant_id)
    end
  end
  describe 'update' do
    it 'allows for the update of an item' do
      put "/api/v1/items/#{Item.last.id}?item[name]=abc&item[description]=hi&item[unit_price]=100"
      res = JSON.parse(response.body)
      expect(res['data']['id'].to_i).to eq(Item.last.id)
      expect(res['data']['attributes']['name']).to eq('abc')
      expect(res['data']['attributes']['description']).to eq('hi')
      expect(res['data']['attributes']['unit_price']).to eq(100)
      expect(res['data']['attributes']['merchant_id']).to eq(Item.last.merchant_id)
    end
  end
  describe 'delete' do
    it 'deletes an item by id' do
      delete "/api/v1/items/#{Item.last.id}"
      res = JSON.parse(response.body)
      expect(response.request.env['action_controller.instance'].response.status).to eq(202)
      expect(Item.where("items.id = ?", res['data']['id'])).to eq([])
    end
  end
end