class CreateBuildings < ActiveRecord::Migration[5.2]
  def change
    create_table :buildings do |t|
      t.string :name , limit: 20, null: false
      t.integer :sekisui_div, default: 0, limit: 1, null: false
      t.string :sekisui_num, default: "", limit: 7, null: false
      t.integer :type_div, default: 0, limit: 2, null: false
      t.float :lat, default: 35.7012,  null: false
      t.float :lon, default: 140.0906,  null: false
      t.string :zip_cd, default: "", limit: 7, null: false
      t.string :address, default: "", limit: 200, null: false
      t.integer :floor
      t.text :memo
      t.references :ooya, foreign_key: true

      t.timestamps
    end
  end
end
