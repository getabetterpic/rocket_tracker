class Motor < ApplicationRecord
  belongs_to :manufacturer

  def self.from_rse(file)
    f = File.open(file, 'rb')
    parsed = Nokogiri::XML(f)
    parsed.css('engine-database engine-list engine').each do |engine|
      manufacturer = Manufacturer.find_or_create_by!(name: engine.attributes['mfg'].value.strip)
      code = engine.attributes['code'].value
      new_motor = find_or_initialize_by(code: code, manufacturer: manufacturer)
      new_motor.single_use = engine.attributes['Type'].value != 'reloadable'
      new_motor.reloadable = engine.attributes['Type'].value == 'reloadable'
      new_motor.diameter = engine.attributes['dia'].value.to_i
      new_motor.specs = engine.attributes.collect { |k, v| [k, v.value] }.to_h
      new_motor.thrust_curve = engine.css('data')[0].css('eng-data').collect do |data|
        data.attributes.collect { |k, v| [k, v.value] }.to_h
      end
      new_motor.save!
    end
  ensure
    f.close
  end
end
