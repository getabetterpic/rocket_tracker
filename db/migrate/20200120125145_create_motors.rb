class CreateMotors < ActiveRecord::Migration[6.0]
  def change
    create_table :motors do |t|
      t.references :manufacturer, null: false
      t.string :code
      t.boolean :single_use
      t.boolean :reloadable
      t.integer :diameter
      t.jsonb :specs
      t.jsonb :thrust_curve

      t.timestamps
    end
  end
end
