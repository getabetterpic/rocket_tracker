json.manufacturers do
  json.array! @manufacturers do |man|
    json.id man.id
    json.name man.name
  end
end
json.total_manufacturers @manufacturers.count
