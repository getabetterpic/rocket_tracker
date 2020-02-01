json.motors do
  json.array! @motors do |motor|
    json.code motor.code
    json.manufacturer motor.manufacturer.name
    json.diameter motor.diameter
    json.reloadable motor.reloadable
  end
end
json.total_motors @motors.count
