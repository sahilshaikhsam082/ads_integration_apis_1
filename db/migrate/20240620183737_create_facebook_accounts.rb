class CreateFacebookAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :facebook_accounts do |t|
      t.references :user, null: false, foreign_key: true
      t.string :facebook_user_id
      t.string :facebook_access_token

      t.timestamps
    end
  end
end
