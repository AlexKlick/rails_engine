require 'rails_helper'

  RSpec.describe 'FindAlls Controller' do
  describe 'show' do
    it 'returns items with partial match of name' do
      m = Merchant.create(name:'a')
      i1 =Item.create(name:"abcd item", merchant_id: m.id)      
      i2 = Item.create(name:"bcde item", merchant_id: m.id)
      i3 = Item.create(name:"cdef item", merchant_id: m.id)
      get '/api/v1/items/find_all?name=bcd'
      res = JSON.parse(response.body)
      expect(res['data'][0]['id'].to_i).to eq(i1.id)
      expect(res['data'][1]['id'].to_i).to eq(i2.id)
      expect(res['data'][0]['attributes']).to eq({"name"=>"abcd item", "description"=>nil, "unit_price"=>nil, "merchant_id"=>i2.merchant_id})
    end
  end
end