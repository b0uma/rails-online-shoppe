class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :status, default: 0
      t.references :user, index: true, foreign_key: true
      t.datetime :checkout_time

      t.timestamps null: false
    end
  end
end
