class CreateTiktokAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :tiktok_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :tiktok_user_id
      t.string :tiktok_access_token

      t.timestamps
    end
  end
end
