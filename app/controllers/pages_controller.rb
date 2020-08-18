class PagesController < ApplicationController
  def index
    @challenges = Challenge.all
  end
  def taxjar
  end
end
