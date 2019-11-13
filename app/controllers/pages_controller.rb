class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home,:social]

  def home
  end
  
  def cgu
  end

  def politiquedeconfidentialite
  end

  def styleguide
    @base_font   = "Roboto"
    @header_font = "Raleway"
  end
  
  def admin2
    unless current_user.admin? || current_user.mods?
      redirect_to root_path
    end
  end
end
