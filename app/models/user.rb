class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create :send_welcome_email

  validates :email, presence: true
  validates :encrypted_password, presence: true
  # validates :description, presence: true
  # validates :first_name, presence: true
  # validates :last_name, presence: true

  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances, foreign_key: "admin_id"

  private

  def send_welcome_email
    UserMailer.welcome_email(self).deliver_now
  end

end
