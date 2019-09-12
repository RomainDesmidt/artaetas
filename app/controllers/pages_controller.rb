class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home,:social]

  def home
  end

  def styleguide
  @base_font   = "Roboto"
  @header_font = "Roboto"
end
end
