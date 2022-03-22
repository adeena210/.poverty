class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :email
      t.integer :num_of_entries
      t.timestamps
    end
  end
end
