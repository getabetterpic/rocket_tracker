json.kits do
  json.array! @kits do |kit|
    json.call(kit, :id, :name, :manufacturer_id)
  end
end
json.total_kits @kits.count
