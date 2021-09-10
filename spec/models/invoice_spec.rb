require 'rails_helper'

RSpec.describe Invoice do
  describe 'relationships' do
    it {should have_many(:transactions)}
    it {should have_many(:invoice_items)}
  end
end