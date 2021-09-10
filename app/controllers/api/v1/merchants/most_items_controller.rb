class Api::V1::Merchants::MostItemsController < ApplicationController
  def show
    status = 200
    if params[:quantity] == nil || params[:quantity] == ""
      status = 400
      hash = {error:{error: "give us the parmagan! I mean, the quantity, do it!"}}
    elsif params[:quantity].to_i <= 0
      status = 400
      hash = {error: {error: 'A string? What am I supposed to do with this? I need an integer! And you call yourself a programmer...'}}
    else
      merchants = Merchant.get_merchants_most_items_sold(params)
      if merchants == []
        hash = {data: []}
      else
        hash = {data: []}
        merchants.each_with_index do |m, i|
          merchant = {id: m.id.to_s, type: 'merchant', attributes: {name: m.name, count: m.count}}
          hash[:data] << merchant
        end
      end
    end
    render json: hash, status: status
  end
end
