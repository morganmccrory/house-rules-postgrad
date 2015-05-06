class SessionsController < ApplicationController

  def new
    @user = current_user
    if @user
      redirect_to user_path(@user)
    end
  end

  def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        log_in(user)
        redirect_to "/users/#{user.id}"
      else
        flash.now[:error] = "Invalid email/password combination"
        render "new"
      end
  end

  def destroy
    log_out if logged_in?
    redirect_to '/login'
  end

end
