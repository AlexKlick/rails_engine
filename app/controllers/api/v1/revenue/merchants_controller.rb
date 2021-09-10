class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity] != "" && params[:quantity] != nil && params[:quantity].to_i > 0
      status = 200
      @merchants = Merchant.get_merchants_revenue_desc(params)
      hash = {data: []}
      @merchants.each_with_index do |m, i|
        merchant = {id: m.id.to_s, type: 'merchant_name_revenue', attributes: {name: m.name, revenue: m.revenue}}
        hash[:data] << merchant
      end
    else
      hash = {error: {error: 'must include the quantity parameter!'}}
      status = 400
    end
    render json: hash, status: status
  end
  def show
    status = 200
    revenue = Merchant.get_merchant_revenue(params[:id])
    if revenue == nil 
      hash = {error: {error: "you done gave us a bad id"}}
      status = 404
    else
      hash = {}
      merchant = {id: revenue.id.to_s, type: 'merchant_revenue', attributes: {revenue: revenue.revenue}}
      hash[:data] = merchant
    end
    render json: hash, status: status
  end
end