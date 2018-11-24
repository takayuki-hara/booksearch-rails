class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, :null => false
      t.string :password_digest, :null => false
      t.integer :role, :null => false
      t.string :email
      t.string :fcm_token
      t.boolean :enable_email_notify, :null => false
      t.boolean :enable_fcm_notify, :null => false

      t.timestamps
    end
  end
end
