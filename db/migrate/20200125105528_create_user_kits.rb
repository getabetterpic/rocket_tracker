class CreateUserKits < ActiveRecord::Migration[6.0]
  def change
    create_table :user_kits do |t|
      t.references :user, null: false
      t.references :kit, null: false

      t.timestamps
    end
  end
end
