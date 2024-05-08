class Attendance < ApplicationRecord

  validates :stripe_customer_id, presence: true

  belongs_to :user
  belongs_to :event

  private

  def send_participation_email
    if Rails.env.development?
      event_admin = self.event.admin
      if event_admin.present?
        ParticipationMailer.send_participation_email(event_admin, self.user).deliver_now
      else
        puts "Impossible d'envoyer l'e-mail de participation car l'événement n'a pas d'administrateur."
      end
    else
      puts "La méthode send_participation_email n'est pas exécutée dans l'environnement de développement."
    end
  end
end
