class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home,:social, :cgu, :politiquedeconfidentialite, :mentionslegales, :quisommesnous, :faq]

  def home
  end
  
  def cgu
  end
  
  def faq
  end
  
  def quisommesnous
  end

  def politiquedeconfidentialite
  end
  
  def mentionslegales
  end

  def styleguide
    @base_font   = "Roboto"
    @header_font = "Raleway"
  end
  
  def changelog
  end
end
