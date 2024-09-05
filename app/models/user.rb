class User < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :cabin_views, dependent: :destroy
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def admin?
    self.admin
  end
end
