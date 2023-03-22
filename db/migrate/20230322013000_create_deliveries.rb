class CreateDeliveries < ActiveRecord::Migration[6.0]
  def change
    create_table :deliveries do |t|
      t.string :status
      t.integer :user_id
      t.date :delivery_date
      t.string :detail
      t.string :description

      t.timestamps
    end
  end
end
