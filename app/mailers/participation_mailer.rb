class ParticipationMailer < ApplicationMailer
  def send_participation_email(user, event)
    @user = user
    @event = event

    mail(to: @user.email, subject: 'Participation Confirmation')
  end
end
