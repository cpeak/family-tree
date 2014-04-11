class PagesController < ApplicationController
  def home
    @person = Person.all

    respond_to do |format|
      format.html
    end
  end

  def login
    render :layout => "login"
  end
end
