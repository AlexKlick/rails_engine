class Api::V1::Revenue::ItemsController < ApplicationController
  def index
    if (params[:quantity] != "" && Float(params[:quantity]) != nil rescue false ) || params[:quantity] == nil
      status = 200
      items = Item.get_revenue_desc(params[:quantity])
      if items != []
        hash = {data:[]}
        items.each_with_index do |m, i|
          item = {id: m.id.to_s, type: 'item_revenue', attributes: {name: m.name, description: m.description, unit_price: m.unit_price, merchant_id: m.merchant_id, revenue: m.revenue}}
          hash[:data] << item
        end
      else
        hash = {data:[]}
      end
    else
      if params[:quantity] == ""
        error = "quantity must not be empty"
      else
        error = "quantity must be a number"
      end
      hash = {error: error}
      status = 400
    end
    render json: hash, status: status
  end
end