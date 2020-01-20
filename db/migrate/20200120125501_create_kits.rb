class CreateKits < ActiveRecord::Migration[6.0]
  def change
    create_table :kits do |t|
      t.references :manufacturer, null: false
      t.string :name

      t.timestamps
    end
  end
end
