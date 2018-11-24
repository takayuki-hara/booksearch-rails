class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title, :null => false
      t.integer :price, :null => false
      t.string :author
      t.string :publisher
      t.string :isbn
      t.string :caption
      t.string :sales_date
      t.string :item_url
      t.string :largeimage_url

      t.timestamps
    end
    add_index :books, :title
  end
end
