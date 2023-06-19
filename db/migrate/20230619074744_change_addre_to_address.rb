class ChangeAddreToAddress < ActiveRecord::Migration[6.1]
  def change
    rename_table :addres, :addresses
  end
end
