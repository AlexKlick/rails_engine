module Api
  module V1
    class MerchantsController < ApplicationController
      def index
        bounds = ApplicationHelper.paginate(params)
        @merchants = Merchant.first(bounds[1])[bounds[0]..bounds[1]]
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
    module Merchants   
      class FindsController < ApplicationController
        def index
          binding.pry
        end
      end   
    end

  end
end