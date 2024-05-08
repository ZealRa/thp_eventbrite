class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :authorize_creator, only: [:destroy, :my_event]

  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)

    if @event.save
      redirect_to root_path, notice: 'Événement créé avec succès.'
    else
      flash.now[:error] = "Erreur lors de la création de l'événement. Veuillez vérifier les champs et réessayer."
      render :new
    end
  end


  def my_event
    @event = Event.find(params[:id])
    @participants = @event.participants
  end

  def edit
    @event = Event.find(params[:id])
  end

  def destroy
  end

  private

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location).merge(user_id: current_user.id)
  end


  def authorize_creator
    @event = Event.find(params[:id])
    unless current_user == @event.user
      flash[:alert] = "Vous n'êtes pas autorisé à effectuer cette action."
      redirect_to root_path
    end
  end

end
