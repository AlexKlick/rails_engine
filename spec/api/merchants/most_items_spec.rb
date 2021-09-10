require 'rails_helper'

  RSpec.describe 'Most Items Controller' do
  describe 'show' do
    let!(:merch) {FactoryBot.create_list(:merchant, 20)}
    let!(:items) {FactoryBot.create_list(:item, 100)}
    xit 'returns the merchants with the most items sold' do
      get '/api/v1/merchants/most_items?quantity=10'
      res = JSON.parse(response.body)
      binding.pry
    end
    it 'thorws error if quantity param not present' do
      get '/api/v1/merchants/most_items'
    end
  end
end