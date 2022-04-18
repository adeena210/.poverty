class AddColumnsToEntry < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :latitude, :float
    add_column :entries, :longitude, :float
  end
end
