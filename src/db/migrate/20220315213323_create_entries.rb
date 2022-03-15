class CreateEntries < ActiveRecord::Migration[6.0]
  def change
    create_table :entries do |t|
      t.string :name
      t.string :address
      t.string :description
      t.boolean :verified

      t.timestamps
    end
  end
end
