class AttendanceController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  # Afficher le formulaire de paiement
  def new
    @event = Event.find(params[:event_id])
    if current_user.attendances.where(event_id: @event.id).exists?
      redirect_to @event, alert: "Vous êtes déjà inscrit à cet événement."
    elsif current_user == @event.admin
      redirect_to @event, alert: "Vous ne pouvez pas vous inscrire à votre propre événement."
    else
      @attendance = Attendance.new
      @stripe_amount = @event.price # ou tout autre montant que tu souhaites facturer
    end
  end

  # Traitement du paiement
  def create
    @event = Event.find(params[:event_id])
    @attendance = Attendance.new(event: @event, user: current_user)
    @stripe_amount = @event.price # ou tout autre montant que tu souhaites facturer

    if @attendance.save
      begin
        customer = Stripe::Customer.create({
          email: current_user.email,
          source: params[:stripeToken],
        })
        charge = Stripe::Charge.create({
          customer: customer.id,
          amount: @stripe_amount * 100, # le montant doit être en centimes
          description: "Inscription à l'événement",
          currency: 'eur',
        })
        redirect_to @event, notice: "Vous êtes maintenant inscrit à l'événement."
      rescue Stripe::CardError => e
        flash[:alert] = e.message
        render :new
      end
    else
      flash[:alert] = "Échec de l'inscription à l'événement."
      render :new
    end
  end
end
