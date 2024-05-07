class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

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
    @event = Event.new(event_params)
    @event.admin = current_user

    if @event.save
      redirect_to root_path, notice: 'Événement créé avec succès.'
    else
      flash.now[:error] = "Erreur lors de la création de l'événement. Veuillez vérifier les champs et réessayer."
      render :new
    end
  end


  private

  def event_params
    params.require(:event).permit(:start_date, :duration, :title, :description, :price, :location)
  end
end
