class TiktokAccount < ApplicationRecord
  belongs_to :user

  def fetch_ad_accounts
    response = HTTParty.get("https://ads.tiktok.com/open_api/v1.2/ad_account/get/", {
      headers: { 'Access-Token' => self.tiktok_access_token }
    })
    JSON.parse(response.body) if response.code == 200
  end
end