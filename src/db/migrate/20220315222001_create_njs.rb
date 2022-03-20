class CreateNjs < ActiveRecord::Migration[6.0]
  def change
    create_table :njs do |t|
      t.string :name
      t.string :address
      t.text :description
      t.boolean :verified

      t.timestamps
    end
  end
end
