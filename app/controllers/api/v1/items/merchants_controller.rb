class Api::V1::Items::MerchantsController < ApplicationController
  def show
    m = Item.find(params[:item_id]).merchant
    hash = {}
    merchant = {id: m.id.to_s, type: 'merchant', attributes: {name: m.name}}
    hash[:data] = merchant
    render json: hash
  end
end