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
  
  def imglist
    @imghash = []
    @imgarray = []
    @userhash = []
    @userarray = []
    Annonce.all.each do |annonce|
      @imgarray << annonce.id
      if annonce.photo?
        @imgarray << annonce.photo.file.public_id
      else
        @imgarray << "none"
      end
      if annonce.photo_un?
        @imgarray << annonce.photo_un.file.public_id
      else
        @imgarray << "none"
      end
      if annonce.photo_deux?
        @imgarray << annonce.photo_deux.file.public_id
      else
        @imgarray << "none"
      end
      @imghash << @imgarray
      @imgarray = []
    end
    
    User.all.each do |user_un|
      @userarray << user_un.id
      if user_un.photofond?
        @userarray << user_un.photofond.file.public_id
      else
        @userarray << "none"
      end
      if user_un.photoprofil?
        @userarray << user_un.photoprofil.file.public_id
      else
        @userarray << "none"
      end
      @userhash << @userarray
      @userarray = []
    end
    
    
  end
end
