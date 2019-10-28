class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user= User.find(params[:id])
    @bookmark = @user.bookmarkees_by(Annonce)
    @bmlist = []
    @bookmark.each do |bm|
    @bmlist << bm.bookmarkee_id
    end
  end

  def me

  end
end
