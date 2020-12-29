class CreateSearches < ActiveRecord::Migration[6.1]
  def change
    create_table :searches do |t|
      t.string :query
      t.text :body

      t.timestamps
    end
    add_index :searches, :query
  end
end
