require 'rails_helper'

describe "Items API" do
  it "sends a list of items" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)

    merchant_items_list1 = create_list(:item, 3, merchant_id: merchant1.id)
    merchant_items_list2 = create_list(:item, 6, merchant_id: merchant2.id)

    get '/api/v1/items'

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    items = response_body[:data]

    expect(items.count).to eq(9)

    items.each do |item|
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