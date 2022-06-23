class UsersController < ApplicationController
  before_action :authenticated_user!

  def info
    require 'stripe'

    customer = Stripe::Customer.retrieve("cus_Lr8QoUxGizP1JF")
    plan = Stripe::Plan.retrieve("price_1L9Q9pBD7K7NNtyY14Bk96Cx")
    # p customer.subscriptions.create(plan: plan)
    @subscription = current_user.subscription
    if @subscription.active
      @stripe_customer = Stripe::Customer.retrieve(@subscription.stripe_user_id)
      @stripe_subscription = @stripe_customer.first
    end
  end

  def cancel_subscription
    @stripe_customer = Stripe::Customer.retrieve(current_user.subscription.stripe_user_id)
    @stripe_subscription = @stripe_customer.first
    @stripe_subscription.delete(@stripe_customer)
    current_user.subscription.active = false
    current_user.subscription.save
    redirect_to users_info_path
  end

  def charge
    #Create customer with nested hash
    customer=Stripe::Customer.create(
      payment_method:'pm_card_visa',
               invoice_settings:{
      })

    current_user.subscription.stripe_user_id =
      customer.id
    current_user.subscription.active = true
    current_user.subscription.save

    redirect_to users_info_path
  end

  private

  def authenticated_user!
    # code here
  end
end
