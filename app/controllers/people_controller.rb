class PeopleController < ApplicationController
  def index
    @people = if params[:query].present?
                Person.where('first_name ILIKE ? OR name ILIKE ?', "%#{params[:query]}%",
                             "%#{params[:query]}%").order(name: :asc)
              else
                Person.all.order(name: :asc)
              end
  end

  def show
    @person = Person.find(params[:id]).preload(:user, :household)
  end

  def new
    @person = Person.new
    @person.user = User.new
    @household = Household.find(params[:household_id])
  end

  def create
    @person = Person.new(person_params)
    @household = Household.find(params[:household_id])
    @person.household = @household
    puts params
    if @person.save
      if user_params[:email].present?
        @user = User.invite!(email: user_params[:email], person: @person) do |u|
          u.skip_invitation = true
        end
        puts @user.inspect
      end
      flash[:success] = "#{@person.full_name} wurde gespeichert."
      redirect_to household_path(@household)
    else
      flash.now[:error] = "Person konnte nicht gespeichert werden.\n#{@person.errors.full_messages.join("\n")}"
      render :new
    end
  end

  def edit
    @person = Person.find(params[:id])
    @household = @person.household
    @person.build_user unless @person.user
  end

  def update
    @person = Person.find(params[:id])
    if @person.update(person_params)
      if user_params[:email].present?
        if @person.user
          @person.user.update(email: user_params[:email])
        else
          @user = User.invite!(email: user_params[:email], person: @person) do |u|
            u.skip_invitation = true
          end
        end
      end
      flash[:success] = "#{@person.full_name} wurde gespeichert."
      redirect_to households_path
    else
      flash.now[:error] = "Person konnte nicht gespeichert werden.\n#{@person.errors.full_messages.join("\n")}"
      render :edit
    end
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :name, :dob, :phone)
  end

  def user_params
    params.require(:user).permit(:email)
  end
end
