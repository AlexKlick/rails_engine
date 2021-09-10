require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it {should belong_to(:merchant)}
    it {should have_many(:invoice_items)}
  end

  describe 'class methods' do
    describe 'get_revenue_desc' do
      it 'returns the items in order of revenue' do
        top_items = Item.get_revenue_desc(10)
      end
    end
  end
  describe 'instance methods' do

  end
end
