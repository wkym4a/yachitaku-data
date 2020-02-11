class CreateOoyas < ActiveRecord::Migration[5.2]
  def change
    create_table :ooyas do |t|
      t.string :surname, limit: 20, null: false
      t.string :name, limit: 20, null: false
      t.string :surname_kana, limit: 40, null: false
      t.string :name_kana, limit: 40, null: false
      t.string :zip_cd, default: "", limit: 7, null: false
      t.string :address1, default: "", limit: 120, null: false
      t.string :address2, default: "", limit: 120, null: false
      t.string :tel, default: "", limit: 20, null: false
      t.string :mobile, default: "", limit: 20, null: false
      t.text :memo, default: "", null: false

      t.timestamps
    end
  end
end
