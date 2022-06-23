class Admin::PublicationsController < ApplicationController
  before_action :find_publication, only: [:show, :edit, :update, :destroy]

  def index
    @publications = Publication.all
  end

  def show; end

  def new
    @publications = Publication.new
  end

  def create
    @publications = Publication.new(publication_params)
    if @publications.save
      redirect_to admin_publication_path(@publications)
    else
      render :new, alert: "Something went wrong."
    end
  end

  def edit; end

  def update
    if @publications.update(publication_params)
      redirect_to admin_publication_path(@publications)
    else
      render :edit, alert: "Something went wrong"
    end
  end

  def destroy
    @publications.destroy
    redirect_to admin_publication_path, alert: "Successfully deleted publications."
  end
  private
  def find_publication
    @publications= Publication.find(params[:id])
  end
  def publication_params
    params.require(:publication).permit(:title, :description, :file_url)
  end
end