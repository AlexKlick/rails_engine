class MerchantsController < ApplicationController
  def index
    if params[:page] || params[:per_page]
      if params[:page].to_i > 0 
        params[:page] = params[:page].to_i
      else
        params[:page] = 1
      end
      if params[:per_page] 
        params[:per_page] = params[:per_page].to_i
      else
        params[:per_page] = 20
      end
      min = (params[:page] - 1) * params[:per_page]
      max = params[:per_page] * params[:page]
      @merchants = Merchant.first(max)[min..max]
    else
      @merchants = Merchant.first(20)
    end
    hash = {data: []}
    @merchants.each_with_index do |m, i|
      merchant = {id: m.id, type: 'merchant', attributes: {name: m.name}}
      hash[:data] << merchant
    end
    render json: hash
  end
  def show
    hash = {}
    merchant = Merchant.find(params[:id])
    @merchant = {id: merchant.id.to_s, type: 'merchant', attributes: {name: merchant.name}}
    hash[:data] = @merchant
    render json: hash
  end
end