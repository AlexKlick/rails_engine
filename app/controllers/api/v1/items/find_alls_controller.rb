module Api
  module V1
    module Items
      class FindAllsController < ApplicationController
        def show
          items = Item.where('name ILIKE ?', "%#{params[:name]}%")
          if params[:name] == nil
            render status: 400
          end
          if items[0] != nil
            hash = {data: []}
            items.each_with_index do |m, i|
              item = {id: m.id.to_s, type: 'item', attributes: {name: m.name, description: m.description, unit_price: m.unit_price, merchant_id: m.merchant_id}}
              hash[:data] << item
            end
          else
            hash = {data: []}
          end
          render json: hash
        end
      end
    end
  end
end