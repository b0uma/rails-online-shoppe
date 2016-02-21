class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.timestamps null: false
    end

    create_join_table :products, :categories do |t|
      t.index :product_id
      t.index :category_id
    end
  end
end
