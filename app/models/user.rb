class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :favorites, dependent: :destroy
  has_many :portfolios, dependent: :destroy
  has_many :posts
  has_many :researches, dependent: :destroy
  has_many :searches, dependent: :destroy

  def set_default_role
    self.role ||= :user
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
