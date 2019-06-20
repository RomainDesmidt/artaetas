class AnnoncesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]

  def index
    @annonces = Annonce.all
  end

  def new
    @annonce = current_user.annonces.new
  end

  def create
    @annonce = current_user.annonces.new(annonce_params)
    @annonce_params = annonce_params
    if  @annonce.save
      # redirect_to '/'
      flash[:error] = "it worked"
    else
      render 'new'
    end
  end



  private

  def annonce_params
    params.require(:annonce).permit(:name, :description, :photo, :photo_cache , :user_id)
  end
end

# {photo: []}
