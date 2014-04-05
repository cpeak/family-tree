class PagesController < ApplicationController
  def stats
    @person = Person.all

    respond_to do |format|
      format.html #index.html.erb
      format.json { render :json => @people }
    end
  end
end
