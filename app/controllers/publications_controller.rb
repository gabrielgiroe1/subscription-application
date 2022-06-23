class PublicationsController < ApplicationController
  before_action :check_for_subscription, only: :show

  def index
    @publications = Publication.all
  end

  def show
    @publications = Publication.find(params[:id])
  end

  def check_for_subscription
    unless current_user.subscription.active
      flash[:alert] = "You must be subscribed to access this content."
      redirect_to publication_path
    end
  end
end