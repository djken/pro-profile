class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string :phone
      t.string :address
      t.string :profession
      t.string :skill
      t.string :fabooklink
      t.string :twitterlink
      t.string :githublink
      t.string :description
      t.integer :user_id, :on_delete => :cascade
      t.timestamps
    end
  end
end
