json.call(@kit, :id, :name, :manufacturer_id)
json.manufacturer_name @kit.manufacturer.name
json.notes @user_kit.notes
