class CreateReleaseWatches < ActiveRecord::Migration[5.2]
  def change
    create_table :release_watches do |t|
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.date :sales_date, :null => false

      t.timestamps
    end
  end
end
