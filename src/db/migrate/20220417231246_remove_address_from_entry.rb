class RemoveAddressFromEntry < ActiveRecord::Migration[6.0]
  def change
    remove_column :entries, :address, :string
  end
end
