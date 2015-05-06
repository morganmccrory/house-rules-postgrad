class UsersController < ApplicationController

  def index
    @house = House.find_by(id: params[:id])
    @users = @house.users
  end

  def show
    if @currentuser = current_user
      @user = User.find(params[:id])
      if @user.id != @currentuser.id
        redirect_to @currentuser
      end
    else
      redirect_to "/login"
    end
  end

  # def index
  # end
  def welcome
    @user = current_user
    if @user
      redirect_to user_path(@user)
    end
  end

  def new
    if @user = current_user
      redirect_to @user
    else
      @user = User.new
    end
  end

  def edit
    @user = current_user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.update_attributes(first_name: @user.first_name.capitalize!, last_name: @user.last_name.capitalize!)
      log_in @user
      flash[:success] = "Welcome!"
      redirect_to user_path(@user)
    else
      flash.now[:error] = "All fields except phone must be present"
      render "users/new"
    end
  end

  def update
    if @user = current_user
      @user = User.find(current_user.id)
      @user.update_attributes(user_params)
      @user.save!
      redirect_to user_path(@user)
    else
      redirect_to '/login'
    end
  end

  # def destroy
  # end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :phone, :avatar, :password)
    end

end
