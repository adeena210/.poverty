class AddZipcodeToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :zipcode, :string
  end
end
