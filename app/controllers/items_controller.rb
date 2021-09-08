class ItemsController < ApplicationController
  include ::PaginationHelper
  def index
    binding.pry
    #bound = paginate(params)
    items = Item.first(bound[1])[bound[0]..bound[1]]
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
  def delete
    Item.destroy(item_params[:id])
    binding.pry
    render status: :deleted
  end
  private

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end

