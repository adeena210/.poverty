class AddTypesToEntries < ActiveRecord::Migration[6.0]
  def change
    add_column :entries, :dropoff, :boolean
    add_column :entries, :aid, :boolean
  end
end
