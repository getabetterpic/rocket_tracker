class AddNotesToUserKit < ActiveRecord::Migration[6.0]
  def change
    add_column :user_kits, :notes, :text
  end
end
