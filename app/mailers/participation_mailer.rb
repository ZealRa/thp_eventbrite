class ParticipationMailer < ApplicationMailer
  def participation_email(event_creator, participant)
    @event_creator = event_creator
    @participant = participant
    mail(to: @event_creator.email, subject: 'Nouvelle participation à votre événement !')
  end
end
