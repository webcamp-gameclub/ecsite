class CreateAddres < ActiveRecord::Migration[6.1]
  def change
    create_table :addres do |t|
      t.integer :customer_id
      t.string :name
      t.string :address
      t.string :pastal_code

      t.timestamps
    end
  end
end
