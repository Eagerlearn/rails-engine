require 'rails_helper'

describe "Merchant Items API" do
  it "sends a list items for a specific merchant" do
    merchant1 = create(:merchant)

    merchant_items_list = create_list(:item, 3, merchant_id: merchant1.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)
  end
    # merchants = response_body[:data]

  #   expect(merchants.count).to eq(3)
  #
  #   merchants.each do |merchant|
  #     expect(merchant).to have_key(:id)
  #     expect(merchant[:id]).to be_a(String)
  #     expect(merchant[:type]).to eq('merchant')
  #     expect(merchant[:attributes]).to have_key(:name)
  #     expect(merchant[:attributes][:name]).to be_a(String)
  #   end
  # end
  #
  # it "can get one merchant by its id" do
  #   id = create(:merchant).id
  #
  #   get "/api/v1/merchants/#{id}"
  #
  #   response_body = JSON.parse(response.body, symbolize_names: true)
  #
  #   merchant = response_body[:data]
  #
  #   expect(merchant).to have_key(:id)
  #   expect(merchant[:id]).to be_a(String)
  #   expect(merchant[:type]).to eq('merchant')
  #   expect(merchant[:attributes]).to have_key(:name)
  #   expect(merchant[:attributes][:name]).to be_a(String)
  # end
end