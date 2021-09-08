module Api
  module V1
    module Merchants
      class FindsController < ApplicationController
        def show
          merchants = Merchant.where('name ILIKE ?', "%#{params[:name]}%")
          hash = {}
          status = 200
          if params[:name] == nil || params[:name] == ""
            status = 400
          elsif merchants[0] != nil
            merchant = {id: merchants[0].id.to_s, type: 'merchant', attributes: {name: merchants[0].name}}
            hash[:data] = merchant
          else
            hash = {data: {}}
          end
          render json: hash, status: status
        end
      end   
    end
  end
end
