class PeopleController < ApplicationController
  def index
  end

  def new
    @person = Person.new
  end
end
