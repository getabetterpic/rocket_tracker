class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.citext :email
      t.string :sub, null: false
      t.string :resource_id

      t.timestamps
      t.index :sub, unique: true
      t.index :resource_id, unique: true
      t.index :email
    end
  end
end
