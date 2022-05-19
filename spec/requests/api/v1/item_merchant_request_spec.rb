require 'rails_helper'

describe "Item merchant API" do
  it "sends for a specific merchant based on item id" do
    merchant1 = create(:merchant)

    merchant_item = create(:item, merchant_id: merchant1.id).id

    get "/api/v1/items/#{merchant_item}/merchant"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant1 = response_body[:data]
  end
end