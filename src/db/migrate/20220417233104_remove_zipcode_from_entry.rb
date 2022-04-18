class RemoveZipcodeFromEntry < ActiveRecord::Migration[6.0]
  def change
    remove_column :entries, :zipcode, :integer
  end
end
