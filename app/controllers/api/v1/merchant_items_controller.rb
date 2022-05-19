class Api::V1::MerchantItemsController < ApplicationController
  def index
    render json: ItemSerializer.new(Item.all)
  end
end