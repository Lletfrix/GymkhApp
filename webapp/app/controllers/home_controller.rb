class HomeController < ApplicationController
  def welcome
    @games = Game.all
  end
end
