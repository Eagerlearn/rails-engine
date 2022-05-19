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

  it "can get one item by its id" do
    merchant1 = create(:merchant)

    merchant_item = create(:item, merchant_id: merchant1.id).id

    get "/api/v1/items/#{merchant_item}"

    expect(response).to be_successful

    response_body = JSON.parse(response.body, symbolize_names: true)

    item = response_body[:data]

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

  it "can create a new item" do
    merchant1 = create(:merchant).id

    item_params = ({
                    name: 'The item',
                    description: 'Best item ever',
                    unit_price: 543.21,
                    merchant_id: merchant1
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    post "/api/v1/items", headers: headers, params: JSON.generate(item: item_params)
    created_item = Item.last

    expect(response).to be_successful
    expect(created_item.name).to eq(item_params[:name])
    expect(created_item.description).to eq(item_params[:description])
    expect(created_item.unit_price).to eq(item_params[:unit_price])
  end

  it 'can update an existing item' do
    merchant1 = create(:merchant)

    merchant_item = create(:item, merchant_id: merchant1.id).id

    prior_name = Item.last.name
    prior_description = Item.last.description

    item_params = ({
                    name: 'Another item',
                    description: 'Better than ever',
                    unit_price: 123.45,
                  })
    headers = {"CONTENT_TYPE" => "application/json"}

    put "/api/v1/items/#{merchant_item}", headers: headers, params: JSON.generate({item: item_params})
    item = Item.find_by(id: merchant_item)

    expect(response).to be_successful
    expect(item.name).to_not eq(prior_name)
    expect(item.description).to_not eq(prior_description)
    expect(item.name).to eq('Another item')
    expect(item.description).to eq('Better than ever')
  end

  it 'can destroy an item' do
    merchant1 = create(:merchant)

    merchant_item = create(:item, merchant_id: merchant1.id).id

    expect(Item.count).to eq(1)

    # delete "/api/v1/items/#{merchant_item}"
    #
    # expect(response).to be_successful
    expect{ delete "/api/v1/items/#{merchant_item}" }.to change(Item, :count).by(-1)
    expect(response).to be_success
    expect{Item.find(merchant_item)}.to raise_error(ActiveRecord::RecordNotFound)
  end
end