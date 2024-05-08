class OrdersController < ApplicationController
  def new
    @user = User.first
    @product = Event.first
    @amount = @product.price
    @stripe_amount = params[:amount].to_i
  end

  def create
    @user = User.first
    @product = Event.first
    @stripe_amount = 1000
    if @stripe_amount <= 0
      flash[:error] = "Le montant doit être supérieur à 0."
      redirect_to new_order_path
      return
    end
    begin
      customer = Stripe::Customer.create({
        email: params[:stripeEmail],
        source: params[:stripeToken],
      })
      charge = Stripe::Charge.create({
        customer: customer.id,
        amount: @stripe_amount,
        description: "Achat d'un produit",
        currency: 'eur',
      })
    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_order_path
    end
  end

end
