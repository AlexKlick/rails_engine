module Api
  module V1
    class ItemsController < ApplicationController
      def index
        bounds = ApplicationHelper.paginate(params)
        items = Item.first(bounds[1])[bounds[0]..bounds[1]]
        hash = {data: []}
        if items
          items.each_with_index do |m, i|
            item = {id: m.id.to_s, type: 'item', attributes: {name: m.name, description: m.description, unit_price: m.unit_price, merchant_id: m.merchant_id}}
            hash[:data] << item
          end
        else
          items = []
        end
        render json: hash
      end
      def show
        hash = {}
        item = Item.find(params[:id])
        if item
          item = {id: item.id.to_s, type: 'item', attributes: {name: item.name, description: item.description, unit_price: item.unit_price, merchant_id: item.merchant_id}}
          hash[:data] = item
        else
          items = []
        end
        render json: hash
      end
      def create
        item = Item.new(item_params)
        if item.save
          hash = {}
          item = {id: item.id.to_s, type: 'item', attributes: {name: item.name, description: item.description, unit_price: item.unit_price, merchant_id: item.merchant_id}}
          hash[:data] = item
          render json: hash, status: :created 
        end
      end
      def update
        item = Item.find(params[:id])
        hash = {}
        status = 200
        if item_params[:merchant_id] != nil && item.merchant_id != item_params[:merchant_id]
          hash = {error: "What were you thinking? You can't change the merchant of an item! That's like saying Google now makes the macbook!?!"}
          status = 400
        else
          item.update(item_params)
          item = {id: item.id.to_s, type: 'item', attributes: {name: item.name, description: item.description, unit_price: item.unit_price, merchant_id: item.merchant_id}}
          hash[:data] = item
        end
        render json: hash, status: status
      end
      def destroy
        item = Item.destroy(params[:id])
        hash = {}
        item = {id: item.id.to_s, type: 'item', attributes: {name: item.name, description: item.description, unit_price: item.unit_price, merchant_id: item.merchant_id}}
        hash[:data] = item
        render json: hash, status: 202
      end
      private

      def item_params
        params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
      end
    end
    end
end