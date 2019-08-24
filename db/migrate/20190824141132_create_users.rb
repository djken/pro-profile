class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :fullname
      t.string :profession
      t.string :email
      t.string :phone
      t.string :description
      t.boolean :confirmed, default: false
      t.string :confirmation_token
      t.string :password_digest
      t.boolean :avatar, default: false
      t.timestamps
    end
  end
end
