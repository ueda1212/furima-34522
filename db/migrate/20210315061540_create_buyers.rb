class CreateBuyers < ActiveRecord::Migration[6.0]
  def change
    create_table :buyers do |t|
      t.string :post_code      null: false
      t.integer :area_id       null: false
      t.string :municipality   null: false
      t.string :address        null: false
      t.string :building_name  null: false
      t.string :phone_number   null: false
      t.references :record     foreign_key: true
      t.timestamps
    end
  end
end
