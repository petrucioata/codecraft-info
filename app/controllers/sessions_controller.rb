class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:login][:email].downcase)

    if user&.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
      flash[:success] = 'Admin was authenticated.'
      redirect_to root_path
    else
      flash[:warning] = 'Wrong credentials'
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
  end
end
