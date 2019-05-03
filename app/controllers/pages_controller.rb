class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home,:social]

  def home
  end
end
