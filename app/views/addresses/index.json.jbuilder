json.array!(@addresses) do |address|
  json.extract! address, :id, :city, :sub_city, :woreda, :kebele, :house_number
  json.url address_url(address, format: :json)
end
