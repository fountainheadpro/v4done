class HomeController < ApplicationController
  #before_filter :authenticate_user!

  def index
    @newest_publications = Publication.newest
    @templates=[Template.new]
  end

end
