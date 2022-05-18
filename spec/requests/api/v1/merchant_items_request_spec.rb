require 'rails_helper'

describe "Merchant Items API" do
  it "sends a list items for a specific merchant" do
    merchant1 = create(:merchant)

    merchant_items_list = create_list(:item, 3, merchant_id: merchant1.id)
# require "pry"; binding.pry
    get "/api/v1/merchants/#{merchant1.id}/items"
    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    merchant_items = response_body[:data]

    expect(merchant_items.count).to eq(3)

    merchant_items.each do |item|
      expect(item).to have_key(:id)
      expect(item[:id]).to be_a(String)
      expect(item[:type]).to eq('item')
      expect(item[:attributes]).to have_key(:name)
      expect(item[:attributes][:name]).to be_a(String)
      expect(item[:attributes]).to have_key(:description)
      expect(item[:attributes][:description]).to be_a(String)
      expect(item[:attributes]).to have_key(:unit_price)
      expect(item[:attributes][:unit_price]).to be_a(Float)
    end
  end
end