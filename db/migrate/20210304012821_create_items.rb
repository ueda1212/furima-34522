class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.string :name
      t.text :description
      t.integer :category_id
      t.integer :status_id
      t.integer :burden_id
      t.integer :area_id
      t.integer :days_id
      t.integer :price
      t.references :user
      t.timestamps
    end
  end
end
