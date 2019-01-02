class CreateKeywords < ActiveRecord::Migration[5.2]
  def change
    create_table :keywords do |t|
      t.references :user, foreign_key: true
      t.string :keyword, :null => false
      t.string :genre, :null => false
      t.integer :item_count

      t.timestamps
    end
  end
end
