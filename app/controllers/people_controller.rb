class PeopleController < ApplicationController
  def index
    authorize Person
    @people = if params[:query].present?
                query = "%#{params[:query]}%"
                Person.where(Person.arel_table[:first_name].matches(query)
                  .or(Person.arel_table[:name].matches(query))).order(name: :asc)
              else
                Person.all.order(name: :asc)
              end
  end

  def show
    @person = Person.preload(:user, :household).find(params[:id])
    authorize @person
  end

  def new
    @person = Person.new
    authorize @person
    @person.user = User.new
    @household = Household.find(params[:household_id])
  end

  def create
    @person = Person.new(person_params)
    authorize @person
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
      flash[:success] = t('controllers.people.create.success')
      redirect_to household_path(@household)
    else
      flash.now[:error] = t('controllers.people.create.error')
      render :new
    end
  end

  def edit
    @person = Person.find(params[:id])
    authorize @person
    @household = @person.household
    @person.build_user unless @person.user
  end

  def update
    @person = Person.find(params[:id])
    authorize @person
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
      flash[:success] = t('controllers.people.update.success')
      redirect_to households_path
    else
      flash.now[:error] = t('controllers.people.update.error')
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
