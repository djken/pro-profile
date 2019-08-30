class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :firstname
      t.string :lastname
      t.string :email
      t.boolean :avatar
      t.string :password_digest
      t.string :confirmation_token
      t.timestamps
    end
  end
end
