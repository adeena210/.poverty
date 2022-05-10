class AddFieldsToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :address_1, :string
    add_column :entries, :address_2, :string
    add_column :entries, :city, :string
    add_column :entries, :state, :string
    add_column :entries, :zipcode, :integer
  end
end
