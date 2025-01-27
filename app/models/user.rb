class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # validates :first_name, :last_name, :company_name, :company_url, presence: true
   has_many :tiktok_accounts, dependent: :destroy    
    has_many :facebook_accounts, dependent: :destroy 
end
