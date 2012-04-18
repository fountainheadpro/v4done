class HomeController < ApplicationController

  def index
    @newest_publications=Publication.newest
  end

end
