class Api::V1::MerchantItemsController < ApplicationController
  def index
    merchant = Merchant.find(params[:id])
    items = Item.all.map do |item|
      item[:id]
    end
    render json: MerchantItemSerializer.new(merchant.items)
  end
end