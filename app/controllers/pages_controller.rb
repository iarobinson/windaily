class PagesController < ApplicationController
  def index
    @challenges = Challenge.all
  end
end
