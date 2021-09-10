require 'rails_helper'

  RSpec.describe 'Finds Controller' do
  describe 'show' do
    it 'finds a single merchant by search' do
      m1 = Merchant.create(name:'abcd Merch')
      m2 = Merchant.create(name:'bcde Merch')
      m3 = Merchant.create(name:'cdef Merch')
      get "/api/v1/merchants/find?name=bcd"
      res = JSON.parse(response.body)
      expect(res['data']['id'].to_i).to eq(m1.id)
      expect(res['data']['attributes']).to eq({"name"=>"abcd Merch"})
    end
  end
end