module Merchants
  class ItemsController < ApplicationController
    def index
      items = Merchant.find(params[:merchant_id]).items
      hash = {data: []}
      items.each_with_index do |m, i|
        merchant = {id: m.id.to_s, type: 'item', attributes: {name: m.name, description: m.description, unit_price: m.unit_price, merchant_id: m.merchant_id}}
        hash[:data] << merchant
      end
      render json: hash
    end
  end
end