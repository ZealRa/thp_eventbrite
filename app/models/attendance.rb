class Attendance < ApplicationRecord
  after_create :send_participation_email

  validates :stripe_customer_id, presence: true

  belongs_to :user
  belongs_to :event

  private

  def send_participation_email
    ParticipationMailer.participation_email(self.event.user, self.user).deliver_now
  end

end
