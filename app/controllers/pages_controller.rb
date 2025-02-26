class PagesController < ApplicationController
  def home
    @mercenaries = Mercenary.limit(6)
  end
end
