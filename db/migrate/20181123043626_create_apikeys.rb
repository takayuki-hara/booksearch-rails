class CreateApikeys < ActiveRecord::Migration[5.2]
  def change
    create_table :apikeys do |t|
      t.string :key, :null => false

      t.timestamps
    end
  end
end
